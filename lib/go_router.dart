part of 'truesight_flutter.dart';

/// Reflector class that constructs `@reflector`
class TrueSightReflector extends Reflectable {
  const TrueSightReflector()
      : super(
          declarationsCapability,
          metadataCapability,
        );

  /// Create a new instance from a specific given Type
  static T newInstance<T>(Type type, {List<dynamic> arguments = const []}) {
    ClassMirror classMirror = reflector.reflectType(type) as ClassMirror;
    return classMirror.newInstance("", arguments) as T;
  }
}

/// The must-have annotation of all classes in the application that need reflection
const reflector = TrueSightReflector();

class UsePageRoute {
  final String path;

  const UsePageRoute(this.path);
}

/// Get routing key of Widget class
String getRoutingKey(Type page) {
  TypeMirror mirror = reflector.reflectType(page);

  var routingKey = "";

  for (var element in mirror.metadata) {
    if (element is UsePageRoute) {
      routingKey = element.path;
      break;
    }
  }

  return routingKey;
}
