import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodiefeedback/core/constants/app_assets.dart';
import 'package:foodiefeedback/core/constants/app_constants.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';
import 'package:foodiefeedback/core/services/networking/network_constants.dart';
import 'package:foodiefeedback/core/services/networking/network_service.dart';
import 'package:foodiefeedback/core/services/notification/notification_service.dart';
import 'package:googleapis_auth/auth_io.dart';

class FCMService implements NotificationService {
  FCMService({required this.networkService}) {
    _instance = this;
  }

  final NetworkService networkService;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Storing the callback and singleton instance
  static FCMService? _instance;
  Function(String)? _onTapCallback;

  static String? _pendingDeepLink;

  @override
  Future<void> initialize(final Function(String)? onNotificationTap) async {
    _onTapCallback = onNotificationTap;
    await _requestPermission();

    try {
      const String topic = AppsConstants.restaurantsCollection;
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (_) {}

    await _initializeLocalNotifications();
    _setupFCMListeners();

    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage?.data != null) {
      final String payload = json.encode(initialMessage!.data);
      _processDeepLink(payload);
      _onTapCallback?.call(_pendingDeepLink ?? '');
    }
  }

  Future<void> _requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// Static function for local notification tap
  static void _onNotificationTap(final NotificationResponse response) {
    _instance?._handleNotificationTap(response);
  }

  /// Instance method to process notification tap
  void _handleNotificationTap(final NotificationResponse response) {
    final String? payload = response.payload;
    if (payload != null) {
      _processDeepLink(payload);
      _onTapCallback?.call(_pendingDeepLink ?? '');
    }
  }

  void _setupFCMListeners() {
    FirebaseMessaging.onMessage.listen(_showLocalNotification);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    final RemoteMessage message,
  ) async {
    await _showLocalNotification(message);
  }

  static Future<void> _showLocalNotification(
    final RemoteMessage message,
  ) async {
    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel_id', //check
            'Default Channel',
            channelDescription:
                'Used for displaying FCM notifications in foreground',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        payload: json.encode(message.data),
      );
    }
  } //study well

  static String _buildDeepLinkUrl(
    final String? route,
    final String? restaurantId,
  ) {
    switch (route) {
      case 'restaurant_detail':
        if (restaurantId != null) {
          final String deepLink = '/restaurantsListingTab/detail/$restaurantId';
          return deepLink;
        }
        return '/restaurantsListingTab';
      case 'restaurants_list':
        return '/restaurantsListingTab';
      case 'add_review':
        if (restaurantId != null) {
          return '/restaurantsListingTab/add-review?restaurantId=$restaurantId';
        }
        return '/restaurantsListingTab';
      case 'settings':
        return '/restaurantsListingTab/settings';
      default:
        return '/restaurantsListingTab';
    }
  }

  static void _processDeepLink(final String deepLinkData) {
    try {
      Map<String, dynamic> linkData;
      try {
        linkData = json.decode(deepLinkData);
      } catch (e) {
        return;
      }

      final String? route = linkData['deep_link'] ?? linkData['route'];
      final String? restaurantId = linkData['restaurant_id'];

      final String deepLinkUrl = _buildDeepLinkUrl(route, restaurantId);
      _pendingDeepLink = deepLinkUrl;
    } catch (e) {
      //
    }
  }

  static String? getPendingDeepLink() {
    final String? link = _pendingDeepLink;
    _pendingDeepLink = null;
    return link;
  }

  @override
  Future<Either<Failure, Unit>> sendNotification({
    required final String title,
    required final String body,
    required final String topic,
    final String? deepLink,
    final String? restaurantId,
    final Map<String, String>? additionalData,
  }) async {
    try {
      final String accessToken = await _getAccessToken();

      final String path = NetworkConstants.sendNotificationPath.replaceAll(
        '{project_id}',
        NetworkConstants.projectId,
      );

      final Map<String, String> notificationData = <String, String>{
        if (deepLink != null) 'deep_link': deepLink,
        if (restaurantId != null) 'restaurant_id': restaurantId,
        ...?additionalData,
      };

      final Map<String, dynamic> payload = <String, Object>{
        'message': <String, Object>{
          'topic': topic,
          'notification': <String, String>{'title': title, 'body': body},
          if (notificationData.isNotEmpty) 'data': notificationData,
          'android': <String, Object>{
            'notification': <String, Object>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
          },
        },
      };

      final Either<Failure, Response<dynamic>> result = await networkService
          .postPath(
            path,
            data: payload,
            headers: <String, String>{
              NetworkConstants.authorizationHeader: 'Bearer $accessToken',
              'Content-Type': NetworkConstants.contentTypeJson,
            },
          );

      return result.fold((failure) => Left(failure), (_) => const Right(unit));
    } catch (e) {
      return Left(Failure("Unexpected error: ${e.toString()}"));
    }
  }

  Future<String> _getAccessToken() async {
    try {
      final String jsonStr = await rootBundle.loadString(AppAssets.serviceAcc);
      final Map<String, dynamic> serviceAccount = json.decode(jsonStr);

      final ServiceAccountCredentials credentials =
          ServiceAccountCredentials.fromJson(serviceAccount);

      final List<String> scopes = <String>[
        'https://www.googleapis.com/auth/firebase.messaging',
      ];
      final AutoRefreshingAuthClient authClient = await clientViaServiceAccount(
        credentials,
        scopes,
      );
      return authClient.credentials.accessToken.data;
    } catch (e) {
      rethrow;
    }
  }
}
