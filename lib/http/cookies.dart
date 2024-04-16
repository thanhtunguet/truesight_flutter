part of 'http.dart';

const _cookieKeyPrefix = "cookie-";

String _getCookieKey(String key) {
  return "$_cookieKeyPrefix$key";
}

String _getCookieKeyReversed(String key) {
  return key.replaceAll(_cookieKeyPrefix, "");
}

bool _isCookieKey(String key) {
  return key.startsWith(_cookieKeyPrefix);
}

Map<String, String> _parseSetCookie(String setCookieString) {
  // Initialize an empty map to store key-value pairs of the cookie
  Map<String, String> cookies = {};
  // Split the Set-Cookie string by '; ' to separate the cookie attributes
  List<String> parts = setCookieString.split('; ');
  // The first part should be the key-value pair of the cookie
  // Check if the first part contains '=', which is necessary for a key-value pair
  if (parts.isNotEmpty && parts[0].contains('=')) {
    // Split the first part by '=' to separate the key and value
    List<String> keyValue = parts[0].split('=');
    if (keyValue.length == 2) {
      // Add the key-value pair to the map
      cookies[_getCookieKey(keyValue[0])] = keyValue[1];
    }
  }
  return cookies;
}

Future<Map<String, dynamic>> _getCookies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Set<String> keys = prefs.getKeys();

  final Map<String, dynamic> prefsMap = {};

  for (String key in keys) {
    if (_isCookieKey(key)) {
      prefsMap[_getCookieKeyReversed(key)] =
          prefs.get(key); // Get value as dynamic
    }
  }

  return prefsMap;
}

Future<void> clearCookies() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Set<String> keys = prefs.getKeys();

  for (String key in keys) {
    if (_isCookieKey(key)) {
      prefs.remove(key);
    }
  }
}
