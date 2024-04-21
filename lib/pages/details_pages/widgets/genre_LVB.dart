import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/constants.dart';

import '../tracks_page.dart';
import 'custom_list_tile.dart';

class GenreListViewBuilder extends StatefulWidget {
  final List<SongModel>? songs;
  final List<GenreModel>? genreList;
  const GenreListViewBuilder(
      {super.key, required this.songs, required this.genreList});

  @override
  State<GenreListViewBuilder> createState() => _GenreListViewBuilderState();
}

class _GenreListViewBuilderState extends State<GenreListViewBuilder> {
  List<SongModel>? fetchedSongs = [];

  Future<List<SongModel>?> findSongsForGenre(int i) async {
    List<SongModel>? songsList = [];
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 =
            song.artist == null ? "" : song.genre!.toLowerCase().trim();
        final String string2 =
            widget.genreList?[i].genre.toLowerCase().trim() ?? "";

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
      itemCount: widget.genreList!.length,
      itemBuilder: (context, index) {
        final data = widget.genreList![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomListTile(
            onTap: () async {
              fetchedSongs!.clear();
              fetchedSongs = await findSongsForGenre(index);
              if (context.mounted) {
                TracksPage(
                  songs: widget.songs,
                  isOtherPage: true,
                  appBarTitle: data.genre,
                ).navigate(context);
              }
            },
            title: data.genre,
            subtitle: data.numOfSongs.toString(),
          ),
        );
      },
    );
  }
}
