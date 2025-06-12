class NetworkConstants {
  static const String baseUrl =
      'https://fcm.googleapis.com';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);
  static const String projectId = 'foodiefeedback-12566';

  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';

  static const String defaultChannelId = 'default_channel_id';
  static const String defaultChannelName = 'Default Channel';
  static const String defaultChannelDescription =
      'Used for displaying FCM notifications in foreground';

  static const String sendNotificationPath =
      '/v1/projects/{project_id}/messages:send';
}
