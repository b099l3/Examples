part of 'counter_bloc.dart';

@freezed
class CounterState with _$CounterBlocState {
  const factory CounterState.loaded({required int counter}) = Loaded;
  const factory CounterState.loading() = Loading;
  const factory CounterState.error({required String message}) = Error;
}
