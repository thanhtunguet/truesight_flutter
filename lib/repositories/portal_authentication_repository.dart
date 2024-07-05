part of 'repositories.dart';

class PortalAuthenticationRepository extends HttpRepository {
  PortalAuthenticationRepository() : super();

  @override
  String? get baseUrl => Uri.parse(truesightService.baseApiUrl)
      .replace(
        path: '/rpc/portal/authentication',
      )
      .toString();

  Future<Tenant> createToken(int id) async {
    return dio.post(
      '/create-token',
      data: {
        'id': id,
      },
    ).then(
      (response) => response.body<Tenant>(),
    );
  }

  Future<List<Tenant>> login(String username, String password) {
    return dio.post(
      '/login',
      data: {
        'username': username,
        'password': password,
      },
    ).then(
      (response) => response.bodyAsList<Tenant>(),
    );
  }

  Future<List<Tenant>> googleLogin(String idToken) async {
    return dio.post(
      '/google-login',
      data: {
        'idToken': idToken,
      },
    ).then(
      (response) => response.bodyAsList<Tenant>(),
    );
  }

  Future<List<Tenant>> appleLogin(String idToken) async {
    return dio.post(
      '/apple-login',
      data: {
        'idToken': idToken,
      },
    ).then(
      (response) => response.bodyAsList<Tenant>(),
    );
  }

  Future<List<Tenant>> microsoftLogin(String idToken) async {
    return dio.post(
      '/microsoft-login',
      data: {
        'idToken': idToken,
      },
    ).then(
      (response) => response.bodyAsList<Tenant>(),
    );
  }
}
