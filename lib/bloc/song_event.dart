part of 'song_bloc.dart';

sealed class SongEvent extends Equatable {
  const SongEvent();
  @override
  List<Object?> get props => [];
}

final class GetSongsEvent extends SongEvent {
  final BuildContext context;

  const GetSongsEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
