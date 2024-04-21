import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/pages/details_pages/widgets/artists_LVB.dart';
import 'package:ui_challenge/pages/details_pages/widgets/no_foo_found.dart';

import 'widgets/app_bar_widget.dart';

class ArtistsPage extends StatefulWidget {
  final List<ArtistModel>? artists;
  final List<SongModel>? songs;
  const ArtistsPage({super.key, required this.artists, required this.songs});

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
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
