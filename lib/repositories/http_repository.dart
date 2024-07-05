part of 'repositories.dart';

abstract class HttpRepository {
  late Dio dio;

  String? get baseUrl;

  bool get useInterceptors => true;

  InterceptorsWrapper get interceptorsWrapper => InterceptorsWrapper();

  addInterceptors(InterceptorsWrapper interceptorsWrapper) {
    dio.interceptors.add(interceptorsWrapper);
  }

  HttpRepository() : dio = Dio() {
    dio.options.baseUrl = baseUrl!;

    if (useInterceptors) {
      dio.interceptors.add(CookieManager(truesightService.persistCookieJar));
      dio.interceptors.add(refreshTokenInterceptor);
      addInterceptors(interceptorsWrapper);
    }
  }
}
