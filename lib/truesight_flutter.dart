library truesight_flutter;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reflectable/reflectable.dart';

import 'truesight_flutter_platform_interface.dart';

part 'data_structure/data_filter.dart';

part 'data_structure/data_list.dart';

part 'data_structure/data_model.dart';

part 'data_structure/data_serialization.dart';

part 'data_structure/order_type.dart';

part 'database.dart';

part 'filters/abstract_filter.dart';

part 'filters/date_filter.dart';

part 'filters/guid_filter.dart';

part 'filters/id_filter.dart';

part 'filters/number_filter.dart';

part 'filters/string_filter.dart';

part 'http/response.dart';

part 'http/http_repository.dart';

part 'reflector.dart';

part 'server_config.dart';

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
