import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/details_pages/tracks_page.dart';
import 'package:ui_challenge/pages/details_pages/widgets/app_bar_widget.dart';
import 'package:ui_challenge/pages/details_pages/widgets/custom_list_tile.dart';
import 'package:ui_challenge/widgets/myTextWidget.dart';

class AlbumsPage extends StatefulWidget {
  final List<AlbumModel>? albums;
  final List<SongModel>? songs;
  const AlbumsPage({super.key, required this.albums, required this.songs});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  List<SongModel>? newSongsList = [];
  Future<List<SongModel>?> parseList(
      int i, List<SongModel>? newSongsList) async {
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 = song.data.toLowerCase().trim();
        final String string2 = widget.albums![i].album.toLowerCase().trim();

        final RegExp regExp = RegExp(r'\b' + RegExp.escape(string2) + r'\b');
        final bool containsString2 = regExp.hasMatch(string1);
        if (containsString2) {
          print(string1);
          print(string2);
          newSongsList?.add(song);
        }
      }
      return newSongsList;
    } else {
      newSongsList = null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Albums",
      ),
      body: widget.albums == null || widget.albums!.isEmpty
          ? const Center(
              child: MyText(
                text: "No albums found",
              ),
            )
          : ListView.builder(
              itemCount: widget.albums!.length,
              itemBuilder: (context, i) {
                final album = widget.albums![i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomListTile(
                    onTap: () async {
                      newSongsList!.clear();
                      final List<SongModel>? fetchedSongs =
                          await parseList(i, newSongsList);
                      TracksPage(
                        songs: fetchedSongs,
                        isAlbum: true,
                        appBarTitle: album.album,
                      ).navigate(context);
                    },
                    title: album.album,
                    artist: album.numOfSongs.toString(),
                  ),
                );
              },
            ),
    );
  }
}
