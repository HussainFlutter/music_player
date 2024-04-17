import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'repeat_state.dart';

class RepeatCubit extends Cubit<RepeatState> {
  RepeatCubit()
      : super(const RepeatState(isRepeatingAll: false, isRepeatingOne: false));
  void repeatOnce() =>
      emit(const RepeatState(isRepeatingAll: false, isRepeatingOne: true));
  void repeatAll() =>
      emit(const RepeatState(isRepeatingAll: true, isRepeatingOne: false));
  void repeatOff() =>
      emit(const RepeatState(isRepeatingAll: false, isRepeatingOne: false));
}
