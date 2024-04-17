part of 'audio_player_repo_cubit.dart';

class ChangePlayerIconState extends Equatable {
  final bool isPlaying;

  const ChangePlayerIconState({required this.isPlaying});

  @override
  List<Object> get props => [isPlaying];
}
