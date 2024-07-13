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

  Future<File> uploadFile({
    required String filePath,
    String uploadUrl = '/upload-file',
  }) async {
    String filename = path.basename(filePath);
    FormData formData = FormData.fromMap(
      {
        'file': await MultipartFile.fromFile(filePath, filename: filename),
      },
    );

    return dio
        .post(
          uploadUrl,
          data: formData,
        )
        .then(
          (response) => response.body<File>(),
        );
  }
}
