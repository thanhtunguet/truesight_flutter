part of 'http.dart';

extension HttpResponse on Response {
  T body<T extends DataModel>() {
    final T model = DataModel.getType(T).constructor() as T;
    model.fromJSON(data);
    return model;
  }

  List<T> bodyAsList<T extends DataModel>() {
    return (data as List).map((element) {
      final T model = DataModel.getType(T).constructor() as T;
      model.fromJSON(element);
      return model;
    }).toList();
  }

  int bodyAsInteger() {
    if (data is String) {
      return int.parse(data);
    }
    if (data is num) {
      return data.toInt();
    }
    return data;
  }

  double bodyAsDouble() {
    return (data as num).toDouble();
  }

  String bodyAsString() {
    return data.toString();
  }

  bool bodyAsBoolean() {
    return bool.parse(data);
  }

  DateTime bodyAsDateTime() {
    return DateTime.parse(data);
  }

  Future<void> saveCookies() async {
    final List<String>? cookies = headers['set-cookie'];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, String> cookieMap = {};
    if (cookies != null) {
      for (var element in cookies) {
        final map = parseSetCookie(element);
        cookieMap.addAll(map);
      }
    }
    for (var element in cookieMap.entries) {
      await prefs.setString(element.key, element.value);
    }
  }
}
