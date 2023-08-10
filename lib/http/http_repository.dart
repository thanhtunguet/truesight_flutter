part of '../truesight_flutter.dart';

/// Repository that has methods to call HTTP APIs
abstract class HttpRepository {
  late final Dio dio;

  StreamSubscription<String>? baseUrlSubscription;

  abstract InterceptorsWrapper interceptorsWrapper;

  bool get useInterceptor;

  ServerConfig get serverConfig {
    return ServerConfig.instance();
  }

  String basePath;

  /// Construct a new HttpRepository instance with baseUrl string
  ///
  /// Each HttpRepository instance has its own dio instance, with unique baseUrl (prefix)
  /// and uses same cookies from base host
  HttpRepository(this.basePath) : super() {
    dio = Dio();
    baseUrlSubscription = serverConfig.subscribe((baseUrl) {
      this.baseUrl = baseUrl;
    });

    if (useInterceptor) {
      dio.interceptors.add(interceptorsWrapper);
    }
  }

  setInterceptors(InterceptorsWrapper interceptorsWrapper) {
    this.interceptorsWrapper = interceptorsWrapper;
  }

  String url(
    String path,
  ) {
    return "$baseUrl/$basePath/$path";
  }

  /// BaseURL of current repository
  /// All API methods with uses it as prefix of API URL
  String get baseUrl {
    return dio.options.baseUrl;
  }

  /// Set base URL of current repository
  set baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  /// Get default content type configuration of this repository
  ContentType get contentType {
    if (dio.options.contentType != null) {
      return ContentType.parse(dio.options.contentType!);
    }
    return ContentType.json;
  }

  /// Set default content type configuration of this repository
  set contentType(ContentType contentType) {
    dio.options.contentType = contentType.mimeType;
  }

  /// Wrap POST method from Dio
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      options: options,
    );
  }

  /// Wrap GET method from Dio
  Future<Response> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      data: data,
    );
  }

  /// Wrap PUT method from Dio
  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.put(
      path,
      cancelToken: cancelToken,
      data: data,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      options: options,
      queryParameters: queryParameters,
    );
  }

  /// Wrap PATCH method from Dio
  Future<Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.patch(
      path,
      cancelToken: cancelToken,
      data: data,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
      options: options,
      queryParameters: queryParameters,
    );
  }

  /// Wrap DELETE method from Dio
  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.delete(
      path,
      cancelToken: cancelToken,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
  }
}
