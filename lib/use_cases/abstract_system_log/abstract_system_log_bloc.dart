import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'abstract_system_log_event.dart';

part 'abstract_system_log_state.dart';

abstract class AbstractSystemLogBloc
    extends Bloc<AbstractSystemLogEvent, AbstractSystemLogState> {
  onSystemLog(
    AbstractSystemLogEvent event,
    Emitter<AbstractSystemLogState> emit,
  );

  AbstractSystemLogBloc() : super(AbstractSystemLogState()) {
    on<AbstractSystemLogEvent>(onSystemLog);
  }
}
