part of 'reflection.dart';

class TrueSightReflector extends Reflectable {
  const TrueSightReflector()
      : super(
          declarationsCapability,
          invokingCapability,
          libraryCapability,
          metadataCapability,
          reflectedTypeCapability,
          typeAnnotationQuantifyCapability,
          topLevelInvokeCapability,
          typeCapability,
          typeRelationsCapability,
          typingCapability,
        );

  static T newInstance<T>(Type type, {List<dynamic> arguments = const []}) {
    ClassMirror classMirror = reflector.reflectType(type) as ClassMirror;
    return classMirror.newInstance("", arguments) as T;
  }
}

const reflector = TrueSightReflector();
