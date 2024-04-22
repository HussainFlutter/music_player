import 'package:equatable/equatable.dart';

class FavoriteSongModel extends Equatable {
  final String? id;
  final String? uri;
  final String? title;
  final String? artist;

  const FavoriteSongModel({
    this.id,
    this.uri,
    this.title,
    this.artist,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uri": uri,
      "title": title,
      "artist": artist,
    };
  }

  factory FavoriteSongModel.fromMap(Map<String, dynamic> map) {
    return FavoriteSongModel(
      id: map["id"],
      uri: map["uri"],
      title: map["title"],
      artist: map["artist"] ?? "Unknown",
    );
  }

  @override
  List<Object?> get props => [
        id,
        uri,
        title,
        artist,
      ];
}
