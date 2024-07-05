import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class _ErrorHandlerService {
  void captureException(error) {
    if (error is Error) {
      if (!kIsWeb) {
        if (Platform.isAndroid || Platform.isIOS) {
          FirebaseCrashlytics.instance.recordError(error, error.stackTrace);
        }
      }
      Sentry.captureException(error);
    }
  }
}

final errorHandlerService = _ErrorHandlerService();
