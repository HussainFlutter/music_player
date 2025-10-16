import 'package:flutter/material.dart';
import 'package:copy_music_player/pages/details_pages/widgets/genre_LVB.dart';
import 'package:copy_music_player/pages/details_pages/widgets/no_foo_found.dart';
import 'package:on_audio_query/on_audio_query.dart';


import 'widgets/app_bar_widget.dart';

class GenrePage extends StatefulWidget {
  final List<GenreModel>? genreList;
  final List<SongModel>? songs;
  const GenrePage({super.key, required this.genreList, required this.songs});

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Genre",
      ),
      body: widget.genreList == null || widget.genreList!.isEmpty
          ? const NoFooFound(text: "No Genre Found")
          : GenreListViewBuilder(
              songs: widget.songs,
              genreList: widget.genreList,
            ),
    );
  }
}
