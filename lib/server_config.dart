import 'dart:async';

import 'package:injectable/injectable.dart';

@singleton
class ServerConfig {
  final _serverConfig = StreamController.broadcast();

  ServerConfig.init();

  void next(String baseUrl) {
    _serverConfig.add(baseUrl);
  }

  void unsubscribe() {
    _serverConfig.close();
  }

  void subscribe(void Function(dynamic) callback) {
    _serverConfig.stream.listen(callback);
  }
}
