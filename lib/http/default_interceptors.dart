part of 'http.dart';

final globalInterceptorsWrapper = InterceptorsWrapper(
  onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    await options.readCookies();
    handler.next(options);
  },
  onResponse: (Response response, ResponseInterceptorHandler handler) async {
    await response.saveCookies();
    return handler.next(response);
  },
  onError: (DioException error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == StatusCode.UNAUTHORIZED) {
      await clearCookies();
    }
    handler.next(error);
  },
);
