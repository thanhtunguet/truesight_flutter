part of 'truesight_flutter.dart';

typedef NewInstanceFunction<T extends DataModel> = T Function();

typedef NewListFunction<T extends DataModel> = List<T> Function(int length);

class TypeMapping<T extends DataModel> {
  final NewInstanceFunction<T> newInstance;

  const TypeMapping({
    required this.newInstance,
  });
}

final Map<Type, TypeMapping> modelMappings = {};
