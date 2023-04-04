part of 'abstract_system_log_bloc.dart';

@immutable
abstract class AbstractSystemLogEvent {}

class SystemLogEvent extends AbstractSystemLogEvent {
  final String className;

  final String methodName;

  SystemLogEvent(this.className, this.methodName) : super();
}
