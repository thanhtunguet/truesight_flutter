part of 'repositories.dart';

class PortalProfileRepository<T extends TruesightAppUser>
    extends HttpRepository {
  @override
  String? get baseUrl => Uri.parse(truesightService.baseApiUrl)
      .replace(
        path: '/rpc/portal/profile',
      )
      .toString();

  Future<T> get() async {
    return dio.post(
      '/get',
      data: {},
    ).then(
      (response) => response.body<T>(),
    );
  }
}
