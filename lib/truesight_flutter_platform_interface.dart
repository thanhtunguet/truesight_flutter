import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'truesight_flutter_method_channel.dart';

abstract class TruesightFlutterPlatform extends PlatformInterface {
  /// Constructs a TruesightFlutterPlatform.
  TruesightFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static TruesightFlutterPlatform _instance = MethodChannelTruesightFlutter();

  /// The default instance of [TruesightFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelTruesightFlutter].
  static TruesightFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TruesightFlutterPlatform] when
  /// they register themselves.
  static set instance(TruesightFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
