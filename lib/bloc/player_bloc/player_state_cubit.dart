import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'player_state_state.dart';

class PlayerStateCubit extends Cubit<PlayerStateState> {
  PlayerStateCubit() : super(const PlayerStateState(isPlaying: true));
}
