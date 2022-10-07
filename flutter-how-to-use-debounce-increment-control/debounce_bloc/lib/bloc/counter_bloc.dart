import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'counter_bloc.freezed.dart';
part 'counter_event.dart';
part 'counter_state.dart';

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({required int initialValue})
      : super(CounterState.loaded(counter: initialValue)) {
    on<CounterChanged>(
      _onCounterChanged,
      transformer: debounce(),
    );
  }

  Future<void> _onCounterChanged(
    CounterChanged event,
    Emitter<CounterState> emit,
  ) async {
    emit(const CounterState.loading());
    // FAKE API Call
    print('Making API call with value: ${event.counter}');
    await Future.delayed(const Duration(seconds: 1), () {
      final response = event.counter;
      print('Received Response from API call of: $response');
      emit(CounterState.loaded(counter: response));
    });
  }
}
