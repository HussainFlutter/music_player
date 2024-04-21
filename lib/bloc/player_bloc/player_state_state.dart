part of 'player_state_cubit.dart';

class PlayerStateState extends Equatable {
  final bool isPlaying;
  const PlayerStateState({required this.isPlaying});

  @override
  List<Object?> get props => [isPlaying];
}
