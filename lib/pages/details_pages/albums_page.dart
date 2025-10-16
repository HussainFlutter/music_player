import 'package:flutter/material.dart';
import 'package:copy_music_player/pages/details_pages/widgets/albums_LVB.dart';
import 'package:copy_music_player/pages/details_pages/widgets/app_bar_widget.dart';
import 'package:copy_music_player/pages/details_pages/widgets/no_foo_found.dart';
import 'package:on_audio_query/on_audio_query.dart';


class AlbumsPage extends StatelessWidget {
  final List<AlbumModel>? albums;
  final List<SongModel>? songs;
  final String? folder;
  const AlbumsPage({
    super.key,
    required this.albums,
    required this.songs,
    this.folder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: folder != null ? folder! : "Albums",
      ),
      body: albums == null || albums!.isEmpty
          ? const NoFooFound(
              text: 'No albums Found',
            )
          : AlbumsFoldersListViewBuilder(
              albums: albums,
              songs: songs,
            ),
    );
  }
}
