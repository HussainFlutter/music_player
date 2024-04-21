import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/details_pages/widgets/custom_list_tile.dart';

import '../tracks_page.dart';

class ArtistsListViewBuilder extends StatefulWidget {
  final List<ArtistModel> artists;
  final List<SongModel>? songs;

  const ArtistsListViewBuilder({
    super.key,
    required this.artists,
    required this.songs,
  });

  @override
  State<ArtistsListViewBuilder> createState() => _ArtistsListViewBuilderState();
}

class _ArtistsListViewBuilderState extends State<ArtistsListViewBuilder> {
  List<SongModel>? fetchedSongs = [];

  Future<List<SongModel>?> findSongsForArtists(int i) async {
    List<SongModel>? songsList = [];
    if (widget.songs!.isNotEmpty && widget.songs != null) {
      for (final song in widget.songs!) {
        final String string1 =
            song.artist == null ? "" : song.artist?.toLowerCase().trim() ?? "";
        final String string2 = widget.artists[i].artist.toLowerCase().trim();

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
      itemCount: widget.artists.length,
      itemBuilder: (context, index) {
        final data = widget.artists[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomListTile(
            onTap: () async {
              fetchedSongs!.clear();
              fetchedSongs = await findSongsForArtists(index);
              if (context.mounted) {
                TracksPage(
                  songs: fetchedSongs,
                  isOtherPage: true,
                  appBarTitle: data.artist,
                ).navigate(context);
              }
            },
            title: data.artist,
            subtitle: data.numberOfTracks == null
                ? ""
                : data.numberOfTracks.toString(),
          ),
        );
      },
    );
  }
}
