import 'package:reflectable/reflectable.dart';

class TrueSightReflector extends Reflectable {
  const TrueSightReflector()
      : super(
          declarationsCapability,
          invokingCapability,
          libraryCapability,
          metadataCapability,
          reflectedTypeCapability,
          topLevelInvokeCapability,
          typeAnnotationQuantifyCapability,
          typingCapability,
        );

  static T newInstance<T>(Type type, {List<dynamic> arguments = const []}) {
    ClassMirror classMirror = reflector.reflectType(type) as ClassMirror;
    return classMirror.newInstance("", arguments) as T;
  }
}

const reflector = TrueSightReflector();
