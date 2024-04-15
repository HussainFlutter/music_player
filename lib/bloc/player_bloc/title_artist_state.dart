part of 'title_artist_cubit.dart';

class TitleArtistState extends Equatable {
  final String title;
  final String? artist;
  const TitleArtistState({
    required this.title,
    required this.artist,
  });

  @override
  List<Object?> get props => [title, artist];
}
