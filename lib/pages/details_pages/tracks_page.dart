import 'package:flutter/material.dart';
import 'package:copy_music_player/pages/details_pages/widgets/app_bar_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';


import '../../widgets/myTextWidget.dart';
import 'widgets/tracks_LVB.dart';

class TracksPage extends StatefulWidget {
  final List<SongModel>? songs;
  final bool isOtherPage;
  final String? appBarTitle;
  const TracksPage({
    super.key,
    required this.songs,
    this.isOtherPage = false,
    this.appBarTitle,
  });

  @override
  State<TracksPage> createState() => _TracksPageState();
}

class _TracksPageState extends State<TracksPage> {

  late List<SongModel> allSongs;
  late List<SongModel> filteredSongs;

  @override
  void initState() {
    super.initState();
    allSongs = widget.songs ?? [];
    filteredSongs = allSongs;
  }

  List<SongModel> searchSongs(
      List<SongModel> songs,
      String query, {
        bool searchTitle = true,
        bool searchAlbum = true,
        bool searchArtist = true,
      }) {
    final normalizedQuery = query.toLowerCase().trim();

    if (normalizedQuery.isEmpty) return List.of(songs);

    return songs.where((song) {
      final titleMatch = searchTitle &&
          song.title.toLowerCase().contains(normalizedQuery);
      final albumMatch = searchAlbum &&
          (song.album ?? '').toLowerCase().contains(normalizedQuery);
      final artistMatch = searchArtist &&
          (song.artist ?? '').toLowerCase().contains(normalizedQuery);

      return titleMatch || albumMatch || artistMatch;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: widget.isOtherPage == false ? "Tracks" : widget.appBarTitle ?? "Tracks",
      ),
      body: widget.songs == null || widget.songs!.isEmpty
          ? const Center(
              child: MyText(
                text: "No tracks found",
              ),
            )
          : Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    filteredSongs = searchSongs(allSongs, value);
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search songs...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              Expanded(
                child: TracksListViewBuilder(
                    songs: filteredSongs,
                  ),
              ),
            ],
          ),
    );
  }
}
