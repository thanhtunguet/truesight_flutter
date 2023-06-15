part of 'reflection.dart';

/// Reflector class that constructs `@reflector`
class TrueSightReflector extends Reflectable {
  const TrueSightReflector()
      : super(
          declarationsCapability,
          invokingCapability,
          reflectedTypeCapability,
          typeCapability,
        );

  /// Create a new instance from a specific given Type
  static T newInstance<T>(Type type, {List<dynamic> arguments = const []}) {
    ClassMirror classMirror = reflector.reflectType(type) as ClassMirror;
    return classMirror.newInstance("", arguments) as T;
  }
}

/// The must-have annotation of all classes in the application that need reflection
const reflector = TrueSightReflector();
