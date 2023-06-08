library truesight_flutter;

import 'package:flutter/widgets.dart';

import 'truesight_flutter_platform_interface.dart';

export 'data_structure/data_structure.dart';
export 'database.dart';
export 'filters/filters.dart';
export 'http_repository.dart';
export 'reflection/reflection.dart';
export 'routes/routes.dart';
export 'server_config.dart';

class TruesightFlutter {
  Future<String?> getPlatformVersion() {
    return TruesightFlutterPlatform.instance.getPlatformVersion();
  }

  static start({
    required String sentryDsn,
    required Widget widget,
  }) async {
    runApp(widget);
  }
}
