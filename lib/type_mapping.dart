part of 'truesight_flutter.dart';

typedef NewInstanceFunction<T extends DataModel> = T Function();

class TypeMapping<T extends DataModel> {
  final NewInstanceFunction<T> newInstance;

  const TypeMapping({
    required this.newInstance,
  });
}

final Map<Type, TypeMapping> typeMappings = {};
