import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'truesight_flutter_platform_interface.dart';

/// An implementation of [TruesightFlutterPlatform] that uses method channels.
class MethodChannelTruesightFlutter extends TruesightFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('truesight_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
