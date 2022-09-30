import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_bloc.freezed.dart';
part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc({required int initialValue})
      : super(CounterState.loaded(counter: initialValue)) {
    on<CounterChanged>(
      _onCounterChanged,
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
