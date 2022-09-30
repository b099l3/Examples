part of 'counter_bloc.dart';

@freezed
class CounterEvent with _$CounterBlocEvent {
  const factory CounterEvent.counterChanged(int counter) = CounterChanged;
}
