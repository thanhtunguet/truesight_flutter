part of 'http.dart';

class TrueSightTokenStorage implements TokenStorage<OAuth2Token> {
  static final baseUri = Uri.parse('${truesightService.baseApiUrl}/rpc/');

  static const String tokenKey = 'Token';

  static const String refreshTokenKey = 'RefreshToken';

  @override
  Future<void> delete() async {
    await truesightService.persistCookieJar.deleteAll();
  }

  static Future<OAuth2Token?> getTokenFromCookieJar() async {
    final cookies =
        await truesightService.persistCookieJar.loadForRequest(baseUri);
    final accessToken =
        cookies.where((cookie) => cookie.name == tokenKey).first;
    final refreshToken =
        cookies.where((cookie) => cookie.name == refreshTokenKey).first;
    if (accessToken.value.isNotEmpty && refreshToken.value.isNotEmpty) {
      return OAuth2Token(
        accessToken: accessToken.value,
        refreshToken: refreshToken.value,
      );
    }
    return null;
  }

  @override
  Future<OAuth2Token?> read() async {
    return getTokenFromCookieJar();
  }

  @override
  Future<void> write(OAuth2Token token) async {
    final accessToken = Cookie(tokenKey, token.accessToken);
    final refreshToken = Cookie(refreshTokenKey, '${token.refreshToken}');

    truesightService.persistCookieJar.saveFromResponse(baseUri, [
      accessToken,
      refreshToken,
    ]);
  }
}

final tokenInterceptor = Fresh.oAuth2(
  tokenStorage: TrueSightTokenStorage(),
  refreshToken: (token, client) async {
    await PortalAuthenticationRepository().refreshToken();
    final token = await TrueSightTokenStorage.getTokenFromCookieJar();
    return token!;
  },
);
