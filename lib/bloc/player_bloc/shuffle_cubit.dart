import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shuffle_state.dart';

class ShuffleCubit extends Cubit<ShuffleState> {
  ShuffleCubit() : super(const ShuffleState(isShuffling: false));
  void changeShuffle(bool shuffle) {
    emit(ShuffleState(isShuffling: shuffle));
  }
}
