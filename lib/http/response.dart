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
    return int.parse(data);
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
}
