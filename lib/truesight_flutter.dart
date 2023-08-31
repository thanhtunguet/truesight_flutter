library truesight_flutter;

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:reflectable/reflectable.dart';

import 'truesight_flutter_platform_interface.dart';

part 'reflector.dart';
part 'routing.dart';
part 'server_config.dart';

class TruesightFlutter {
  Future<String?> getPlatformVersion() {
    return TruesightFlutterPlatform.instance.getPlatformVersion();
  }
}
