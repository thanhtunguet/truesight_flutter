part of 'repositories.dart';

abstract class HttpRepository extends Repository {
  late final Dio dio;

  HttpRepository({
    String? baseUrl,
  }) : super() {
    dio = Dio();
    dio.interceptors.add(CookieManager(PersistCookieJar()));
    if (baseUrl != null) {
      this.baseUrl = baseUrl;
    }
  }

  String get baseUrl {
    return dio.options.baseUrl;
  }

  set baseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    dio.options.contentType = ContentType.json.mimeType;
  }

  ContentType get contentType {
    if (dio.options.contentType != null) {
      return ContentType.parse(dio.options.contentType!);
    }
    return ContentType.json;
  }

  set contentType(ContentType contentType) {
    dio.options.contentType = contentType.mimeType;
  }

  Future<Response> post(
    String url, {
    dynamic data,
  }) {
    return dio.post(url, data: data);
  }

  Future<Response> get(
    String url, {
    dynamic queryParameters,
  }) {
    return dio.get(url, queryParameters: queryParameters);
  }
}
