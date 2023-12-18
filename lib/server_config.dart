part of 'truesight_flutter.dart';

/// This class manages the Url of backend server
class ServerConfig {
  static ServerConfig? _instance;

  final _serverConfig = StreamController<String>.broadcast();

  void next(String baseUrl) {
    _serverConfig.add(baseUrl);
  }

  void unsubscribe() {
    _serverConfig.close();
  }

  StreamSubscription<String> subscribe(dynamic Function(String) callback) {
    return _serverConfig.stream.listen(callback);
  }

  ServerConfig._staticInit() {
    _instance = this;
  }

  ServerConfig.init();

  factory ServerConfig.instance() {
    if (_instance == null) {
      ServerConfig._staticInit();
    }
    return _instance!;
  }
}
