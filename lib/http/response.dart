import 'package:dio/dio.dart';

import '../data_structure/data_model.dart';
import '../reflection/reflector.dart';

extension ExtendedResponse on Response {
  T body<T extends DataModel>() {
    T model = TrueSightReflector.newInstance<T>(T);
    model.fromJSON(data);
    return model;
  }

  List<T> list<T extends DataModel>() {
    return data.map((element) {
      T model = TrueSightReflector.newInstance<T>(T);
      model.fromJSON(element);
      return model;
    });
  }
}
