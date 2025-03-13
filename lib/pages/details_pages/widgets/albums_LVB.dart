import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/details_pages/widgets/custom_list_tile.dart';

import '../tracks_page.dart';

class AlbumsFoldersListViewBuilder extends StatefulWidget {
  final List<AlbumModel>? albums;
  final List<SongModel>? songs;

  const AlbumsFoldersListViewBuilder({
    super.key,
    required this.albums,
    required this.songs,
  });

  @override
  State<AlbumsFoldersListViewBuilder> createState() =>
      _AlbumsFoldersListViewBuilderState();
}

class _AlbumsFoldersListViewBuilderState
    extends State<AlbumsFoldersListViewBuilder> {
  List<SongModel>? fetchedSongs = [];

  Future<List<SongModel>?> findSongsForAlbums(int i) async {
    List<SongModel>? songsList = [];
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 = song.data.toLowerCase().trim();
        final String? string2 =
            widget.albums?[i].album.toLowerCase().trim();
 if (string2 != null){
final RegExp regExp = RegExp(r'\b' + RegExp.escape(string2) + r'\b');
        final bool containsString2 = regExp.hasMatch(string1);
        if (containsString2) {
          songsList.add(song);
        }
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
      itemCount: widget.albums!.length,
      itemBuilder: (context, index) {
        final data = widget.albums![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomListTile(
            onTap: () async {
              fetchedSongs!.clear();
              fetchedSongs = await findSongsForAlbums(index);
              if (context.mounted) {
                TracksPage(
                  songs: fetchedSongs,
                  isOtherPage: true,
                  appBarTitle: data.album,
                ).navigate(context);
              }
            },
            title: data.album,
            subtitle: data.numOfSongs.toString(),
          ),
        );
      },
    );
  }
}
