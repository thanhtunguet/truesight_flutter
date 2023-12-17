library truesight_flutter;

import 'dart:async';

import 'truesight_flutter_platform_interface.dart';

export 'package:truesight_core/truesight_core.dart';

part 'server_config.dart';

class TruesightFlutter {
  Future<String?> getPlatformVersion() {
    return TruesightFlutterPlatform.instance.getPlatformVersion();
  }
}
