import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/pages/details_pages/widgets/no_foo_found.dart';
import 'package:ui_challenge/pages/details_pages/widgets/playlist_list_view_builder.dart';

import 'widgets/app_bar_widget.dart';

class ArtistsPage extends StatefulWidget {
  final List<ArtistModel>? artists;
  final List<SongModel>? songs;
  const ArtistsPage({super.key, required this.artists, required this.songs});

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  List<SongModel>? newSongsList = [];
  Future<List<SongModel>?> parseList(int i) async {
    List<SongModel>? songsList = [];
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 = song.data.toLowerCase().trim();
        final String string2 = widget.artists![i].artist.toLowerCase().trim();

        final RegExp regExp = RegExp(r'\b' + RegExp.escape(string2) + r'\b');
        final bool containsString2 = regExp.hasMatch(string1);
        if (containsString2) {
          print(string1);
          print(string2);
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
        title: "Artists",
      ),
      body: widget.artists!.isEmpty || widget.artists == null
          ? const NoFooFound(
              text: 'No Artists Found',
            )
          : ArtistsListViewBuilder(
              artists: widget.artists!,
              songs: widget.songs,
            ),
    );
  }
}
