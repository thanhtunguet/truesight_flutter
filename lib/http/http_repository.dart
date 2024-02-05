part of 'http.dart';

abstract class HttpRepository {
  /// Repository instances
  static final List<HttpRepository> _instances = [];

  static addInstance(HttpRepository instance) {
    _instances.add(instance);
  }

  /// Each HttpRepository class has its own Dio instance
  /// This instance is used to make requests, has isolated configuration
  late Dio _dio;

  /// Whether this repository uses the baseUrl from this getter, returns the baseUrl
  /// If the baseUrl should be watched from a stream, state or something else, returns null
  String? get baseUrl;

  String url(String path) {
    return "$baseUrl/$path";
  }

  /// Set the baseUrl for dio instance
  set baseUrl(String? baseUrl) {
    if (baseUrl != null) {
      _dio.options.baseUrl = baseUrl;
    }
  }

  /// Whether this repository uses interceptors or not
  /// Derived classes should override this to change the behavior
  bool get useInterceptors => true;

  /// InterceptorsWrapper for this repository
  /// Must be set if useInterceptors is true
  abstract InterceptorsWrapper interceptorsWrapper;

  /// BaseOptions for Dio
  /// Will be used to initialize the dio instance
  BaseOptions? get options => null;

  addInterceptors(InterceptorsWrapper interceptorsWrapper) {
    _dio.interceptors.add(interceptorsWrapper);
  }

  /// Abstract constructor
  HttpRepository() {
    _dio = Dio(options);
    addInstance(this);
    if (useInterceptors) {
      addInterceptors(interceptorsWrapper);
    }
    if (baseUrl != null) {
      baseUrl = baseUrl;
    }
  }

  /// Wrap request method from Dio
  Future<Response> request(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Wrap POST method from Dio
  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
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
    return _dio.get(
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
    return _dio.put(
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
    return _dio.patch(
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
    return _dio.delete(
      path,
      cancelToken: cancelToken,
      data: data,
      options: options,
      queryParameters: queryParameters,
    );
  }

  Future<Response> download(
    String urlPath,
    dynamic savePath, {
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Object? data,
    Options? options,
  }) {
    return _dio.download(
      urlPath,
      savePath,
      onReceiveProgress: onReceiveProgress,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      lengthHeader: lengthHeader,
      data: data,
      options: options,
    );
  }
}
