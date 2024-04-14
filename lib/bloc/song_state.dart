part of 'song_bloc.dart';

sealed class SongState extends Equatable {
  const SongState();
}

final class SongInitial extends SongState {
  @override
  List<Object> get props => [];
}

class SongsLoaded extends SongState {
  final List<SongModel>? songs;
  final List<AlbumModel>? albums;
  final List<ArtistModel>? artists;
  final List<GenreModel>? genres;
  final List<PlaylistModel>? playlists;

  const SongsLoaded({
    required this.songs,
    required this.albums,
    required this.artists,
    required this.genres,
    required this.playlists,
  });

  @override
  List<Object?> get props => [
        songs,
        albums,
        artists,
        genres,
        playlists,
      ];
}
