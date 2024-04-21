import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/constants.dart';

import '../../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../../bloc/player_bloc/duration_cubit.dart';
import '../../player_page/player_page.dart';
import 'custom_list_tile.dart';

class TracksListViewBuilder extends StatelessWidget {
  final List<SongModel> songs;
  const TracksListViewBuilder({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final data = songs;
        return GestureDetector(
          onTap: () {
            context
                .read<AudioPlayerRepoCubit>()
                .playAudio(data, context, index);
            context.read<DurationCubit>().giveDuration();
            const PlayerPage().navigate(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomListTile(
              title: data[index].title,
              subtitle: data[index].artist,
            ),
          ),
        );
      },
    );
  }
}
