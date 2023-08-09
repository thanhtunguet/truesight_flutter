part of 'truesight_flutter.dart';

class ServerConfig {
  final _serverConfig = StreamController.broadcast();

  static ServerConfig? _instance;

  void next(String baseUrl) {
    _serverConfig.add(baseUrl);
  }

  void unsubscribe() {
    _serverConfig.close();
  }

  void subscribe(void Function(dynamic) callback) {
    _serverConfig.stream.listen(callback);
  }

  ServerConfig._init() {
    _instance = this;
  }

  factory ServerConfig.instance() {
    if (_instance == null) {
      ServerConfig._init();
    }
    return _instance!;
  }
}
