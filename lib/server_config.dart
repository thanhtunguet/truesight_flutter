import 'dart:async';

final StreamController<String> serverConfig = StreamController<String>();

void initializeServerConfig(String baseUrl) {
  serverConfig.add(baseUrl);
}
