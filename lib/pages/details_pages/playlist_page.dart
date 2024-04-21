import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/pages/details_pages/widgets/no_foo_found.dart';
import 'package:ui_challenge/pages/details_pages/widgets/playList_LVB.dart';

import 'widgets/app_bar_widget.dart';

class PlaylistPage extends StatefulWidget {
  final List<PlaylistModel>? playLists;
  final List<SongModel>? songs;
  const PlaylistPage({super.key, required this.playLists, required this.songs});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<SongModel>? fetchedSongs = [];

  Future<List<SongModel>?> findSongsForPlaylist(int i) async {
    List<SongModel>? songsList = [];
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 =
            song.artist == null ? "" : song.artist?.toLowerCase().trim() ?? "";
        final String string2 =
            widget.playLists![i].playlist.toLowerCase().trim();

        if (string1 == string2) {
          debugPrint(string1);
          debugPrint(string2);
          songsList.add(song);
        }
      }
      return songsList;
    } else {
      songsList = null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Playlist",
      ),
      body: widget.playLists == null || widget.playLists!.isEmpty
          ? const NoFooFound(text: "No PlayLists Found")
          : PlayListListViewBuilder(
              songs: widget.songs,
              playLists: widget.playLists,
            ),
    );
  }
}
