import 'package:reflectable/mirrors.dart';
import 'package:truesight_flutter/truesight_flutter.dart';
import 'package:truesight_flutter/use_cases/abstract_system_log/abstract_system_log_bloc.dart';

mixin Logger {
  AbstractSystemLogBloc get systemLogBloc;

  log(Function function) {
    var instanceMirror = reflector.reflect(this);
    var methodMirror = reflector.reflect(function);
    var classMirror = instanceMirror.type;
    var className = classMirror.simpleName;
    var methodName = '';

    /// Find methodName
    instanceMirror.type.declarations.forEach(
      (key, value) {
        if (value is MethodMirror) {
          if (value.isRegularMethod) {
            if (instanceMirror.invokeGetter(key) == function) {
              methodName = value.simpleName;
              var systemLogEvent = SystemLogEvent(className, methodName);
              systemLogBloc.add(systemLogEvent);
              return;
            }
          }
        }
      },
    );
  }
}
