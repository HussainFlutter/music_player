import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/pages/details_pages/widgets/app_bar_widget.dart';
import 'package:ui_challenge/widgets/myTextWidget.dart';

import 'widgets/tracks_LVB.dart';

class TracksPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: isOtherPage == false ? "Tracks" : appBarTitle ?? "Tracks",
      ),
      body: songs == null || songs!.isEmpty
          ? const Center(
              child: MyText(
                text: "No tracks found",
              ),
            )
          : TracksListViewBuilder(
              songs: songs!,
            ),
    );
  }
}
