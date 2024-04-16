part of 'http.dart';

extension RequestExtension on RequestOptions {
  Future<void> readCookies() async {
    final cookies = await _getCookies();

    final cookieString = cookies.entries.map((element) {
      return "${element.key}=${element.value}";
    }).join(";");

    headers.addAll({
      'cookie': cookieString,
    });
  }
}
