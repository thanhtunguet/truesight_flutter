library truesight_flutter;

import 'dart:async';

import 'package:flutter/services.dart';

export 'data_structure/data_structure.dart';
export 'filters/filters.dart';
export 'http/http.dart';
export 'reflection/reflection.dart';
export 'repositories/repositories.dart';
export 'routes/routes.dart';

final StreamController<String> serverConfig = StreamController<String>();

void initializeServerConfig(String baseUrl) {
  serverConfig.add(baseUrl);
}

const MethodChannel _channel = MethodChannel('truesight_channel');

void sendGoogleMapsApiKey({required String apiKey}) {
  _channel.invokeMethod('sendGoogleMapsApiKey', apiKey);
}
