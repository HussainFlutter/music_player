import 'dart:async';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'favorite_song_model.dart';

class HiveRepo {
  final String _boxName = "Favorite_Tracks";
  late Box _box;
  Box get box => _box;

  Future<void> get openBox async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(documentDirectory.path);
    _box = await Hive.openBox(_boxName);
  }

  void removeFromFavorite(int key) => box.delete(key);

  void addToFavorite(FavoriteSongModel songModel) async {
    _box.put(songModel.id, songModel.toMap());
  }

  void get clearBox async => _box.clear();
}
