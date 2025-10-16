import 'package:flutter/material.dart';
import 'package:copy_music_player/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../tracks_page.dart';
import 'custom_list_tile.dart';

class PlayListListViewBuilder extends StatefulWidget {
  final List<SongModel>? songs;
  final List<PlaylistModel>? playLists;
  const PlayListListViewBuilder({
    super.key,
    required this.songs,
    required this.playLists,
  });

  @override
  State<PlayListListViewBuilder> createState() =>
      _PlayListListViewBuilderState();
}

class _PlayListListViewBuilderState extends State<PlayListListViewBuilder> {
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
    return ListView.builder(
      itemCount: widget.playLists!.length,
      itemBuilder: (context, index) {
        final data = widget.playLists![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomListTile(
            onTap: () async {
              fetchedSongs!.clear();
              fetchedSongs = await findSongsForPlaylist(index);
              if (context.mounted) {
                TracksPage(
                  songs: widget.songs,
                  isOtherPage: true,
                  appBarTitle: data.playlist,
                ).navigate(context);
              }
            },
            title: data.playlist,
            subtitle: data.numOfSongs.toString(),
          ),
        );
      },
    );
  }
}
