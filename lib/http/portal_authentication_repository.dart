part of 'http.dart';

class PortalAuthenticationRepository extends HttpRepository {
  @override
  String? get baseUrl =>
      '${truesightService.baseApiUrl}/rpc/portal/authentication';

  Future<void> refreshToken() {
    return post(url('refresh-token'), data: {})
        .then((response) => response.data);
  }

  Future<Tenant> createToken(int id) async {
    return post(url('create-token'), data: {
      'id': id,
    }).then(
      (response) => response.body<Tenant>(),
    );
  }

  Future<TruesightAppUser> login(String username, String password) {
    return post(url('login'), data: {
      'username': username,
      'password': password,
    }).then(
      (response) => response.body<TruesightAppUser>(),
    );
  }
}
