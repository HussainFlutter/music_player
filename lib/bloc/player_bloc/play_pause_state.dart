part of 'play_pause_cubit.dart';

class ChangePlayerIconState extends Equatable {
  final bool isPlaying;

  const ChangePlayerIconState({required this.isPlaying});

  @override
  List<Object> get props => [isPlaying];
}
