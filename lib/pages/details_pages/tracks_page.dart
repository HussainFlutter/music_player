import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/details_pages/widgets/app_bar_widget.dart';
import 'package:ui_challenge/pages/player_page/player_page.dart';
import 'package:ui_challenge/widgets/myTextWidget.dart';

import '../../bloc/player_bloc/play_pause_cubit.dart';
import 'widgets/custom_list_tile.dart';

class TracksPage extends StatelessWidget {
  final List<SongModel>? songs;
  const TracksPage({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Tracks",
      ),
      body: songs == null || songs!.isEmpty
          ? const Center(
              child: MyText(
                text: "No tracks found",
              ),
            )
          : ListView.builder(
              itemCount: songs!.length,
              itemBuilder: (context, index) {
                final data = songs![index];
                return GestureDetector(
                  onTap: () {
                    context.read<PlayPauseCubit>().playAudio(data.data);
                    context.read<DurationCubit>().giveDuration();
                    PlayerPage(
                      title: data.title,
                      artist: data.artist,
                    ).navigate(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomListTile(
                      title: data.title,
                      artist: data.artist,
                    ),
                  ),
                );
              }),
    );
  }
}
