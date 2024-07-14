part of 'repositories.dart';

class UtilsNotificationRepository extends HttpRepository {
  @override
  String get baseUrl =>
      '${truesightService.baseApiUrl}/rpc/utils-notification/notification';

  Future<bool> createToken(
    String token, {
    String deviceModel = '',
    String osVersion = '',
    num globalUserId = 0,
  }) async {
    return dio.post(
      '/create-token',
      data: {
        'globalUserId': globalUserId,
        'deviceModel': deviceModel,
        'osVersion': osVersion,
        'token': token,
      },
    ).then(
      (response) => response.data,
    );
  }

  Future<bool> deleteToken(
    String token, {
    String deviceModel = '',
    String osVersion = '',
    num globalUserId = 0,
  }) async {
    return dio.post(
      '/delete-token',
      data: {
        'globalUserId': globalUserId,
        'deviceModel': deviceModel,
        'osVersion': osVersion,
      },
    ).then(
      (response) => response.data,
    );
  }
}
