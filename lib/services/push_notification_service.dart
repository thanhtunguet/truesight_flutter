import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:truesight_flutter/truesight_flutter.dart';

class _PushNotificationService {
  final notificationRepo = UtilsNotificationRepository();

  Future<void> configureNotification(int globalUserId) async {
    await FirebaseMessaging.instance.requestPermission(provisional: true);
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('FIREBASE_TOKEN = $token');
    if (token != null) {
      await notificationRepo
          .createToken(
        token,
        globalUserId: globalUserId,
      )
          .catchError((error) {
        errorHandlerService.captureException(error);
        return false;
      });
    }
  }

  /// Deletes the current token from the notification repository.
  ///
  /// This function retrieves the current token using the `FirebaseMessaging.instance.getToken()`
  /// method. If the token is not null, it attempts to delete the token from the notification
  /// repository using the `notificationRepo.deleteToken(currentToken)` method. If an error
  /// occurs during the deletion process, it is captured using the `errorHandler.captureException(error)`
  /// method.
  ///
  /// This function is asynchronous and returns a `Future<void>`.
  Future<void> deleteToken() async {
    final currentToken = await FirebaseMessaging.instance.getToken();

    if (currentToken != null) {
      try {
        await notificationRepo.deleteToken(currentToken);
      } catch (error) {
        errorHandlerService.captureException(error);
      }
    }
  }
}

final pushNotificationService = _PushNotificationService();
