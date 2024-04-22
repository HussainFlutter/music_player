import 'package:hive/hive.dart';
import 'package:ui_challenge/favorite_song_model.dart';
import 'package:uuid/uuid.dart';

class HiveRepo {
  final Uuid _randomId = const Uuid();
  final String _boxName = "Favorite_Tracks";
  late Box _box;
  Future<void> get openBox async => _box = await Hive.openBox(_boxName);
//   void test () {
//     _box.add(value);
//     _box.get(value.id);
//     _box.delete(key);
// }
  void addToFavorite(FavoriteSongModel songModel) {
    final FavoriteSongModel song = FavoriteSongModel(
      id: _randomId.v1(),
      title: songModel.title,
      uri: songModel.uri,
      artist: songModel.artist,
    );
    _box.add(song.toMap());
  }

  void removeFromFavorite(String key) => _box.delete(key);
  List<FavoriteSongModel>? get getAllFavorites {
    final List<FavoriteSongModel> favoriteSongs = [];
    for (var key in _box.keys) {
      favoriteSongs.add(FavoriteSongModel.fromMap(_box.get(key)));
    }
    if (favoriteSongs.isEmpty) {
      return null;
    } else {
      return favoriteSongs;
    }
  }
}
