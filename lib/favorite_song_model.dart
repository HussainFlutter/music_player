import 'package:equatable/equatable.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteSongModel extends Equatable {
  final int? id;
  final String? data;
  final String? title;
  final String? artist;

  const FavoriteSongModel({
    this.id,
    this.data,
    this.title,
    this.artist,
  });

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "_data": data,
      "title": title,
      "artist": artist,
    };
  }

  factory FavoriteSongModel.fromMap(Map<dynamic, dynamic> map) {
    return FavoriteSongModel(
      id: map["_id"],
      data: map["_data"],
      title: map["title"],
      artist: map["artist"] ?? "Unknown",
    );
  }

  SongModel toSongModelFav() => SongModel(
        toMap(),
      );

  @override
  List<Object?> get props => [
        id,
        data,
        title,
        artist,
      ];
}
