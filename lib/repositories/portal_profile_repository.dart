part of 'repositories.dart';

class PortalProfileRepository extends HttpRepository {
  @override
  String? get baseUrl => Uri.parse(truesightService.baseApiUrl)
      .replace(
        path: '/rpc/portal/profile',
      )
      .toString();

  Future<TruesightAppUser> get() async {
    return dio.post(
      '/get',
      data: {},
    ).then(
      (response) => response.body<TruesightAppUser>(),
    );
  }
}
