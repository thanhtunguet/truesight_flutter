part of 'repositories.dart';

final refreshTokenInterceptor = InterceptorsWrapper(
  onError: (DioException error, handler) async {
    if (error.response?.statusCode == StatusCode.unauthorized) {
      if (error.requestOptions.uri.toString().endsWith('refresh-token')) {
        throw error;
      }
      await TokenRepository().refreshToken().then(
        (refreshResponse) async {
          final response = await Dio().fetch(error.requestOptions);

          handler.resolve(response);
        },
      ).catchError(
        (refreshError) {
          throw error;
        },
      );
    }
  },
);
