part of 'repositories.dart';

class TokenRepository extends HttpRepository {
  @override
  bool get useInterceptors => false;

  @override
  String get baseUrl => Uri.parse(truesightService.baseApiUrl)
      .replace(
        path: '/rpc/portal/authentication',
      )
      .toString();

  TokenRepository() : super() {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(CookieManager(truesightService.persistCookieJar));
  }

  Future<void> refreshToken() {
    return dio.post(
      '/refreshToken',
      data: {},
    ).then(
      (response) => response.data,
    );
  }
}
