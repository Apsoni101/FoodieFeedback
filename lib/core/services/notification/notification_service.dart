import 'package:dartz/dartz.dart';
import 'package:foodiefeedback/core/services/error/failure.dart';

abstract class NotificationService {
  Future<void> initialize(final Function(String)? onNotificationTap);

  Future<Either<Failure, Unit>> sendNotification({
    required final String title,
    required final String body,
    required final String topic,
    final String? deepLink,
    final String? restaurantId,
    final Map<String, String>? additionalData,
  });
}
