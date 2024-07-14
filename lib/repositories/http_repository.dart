part of 'repositories.dart';

abstract class HttpRepository {
  static Completer<void>? _refreshCompleter;

  static Future<void> refreshToken() async {
    return await PortalAuthenticationRepository()
        .refreshToken()
        .catchError((error) {
      throw error;
    });
  }

  static final refreshInterceptor = InterceptorsWrapper(
    onError: (DioException error, ErrorInterceptorHandler handler) async {
      if (error.response?.statusCode == 401) {
        if (_refreshCompleter == null) {
          _refreshCompleter = Completer<void>();
          try {
            await refreshToken();
            _refreshCompleter?.complete();
          } catch (refreshError) {
            _refreshCompleter?.completeError(refreshError);
          } finally {
            _refreshCompleter = null;
          }
        }

        try {
          await _refreshCompleter?.future;
          final dio = Dio();
          dio.interceptors
              .add(CookieManager(truesightService.persistCookieJar));
          final response = await dio.fetch(error.requestOptions);
          return handler.resolve(response);
        } catch (refreshError) {
          await GetIt.instance.get<UserBloc>().logout();
          handler.next(error);
        }
      } else {
        return handler.next(error);
      }
    },
  );

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
