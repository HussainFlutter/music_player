import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_music_player/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../../bloc/player_bloc/duration_cubit.dart';
import '../../player_page/player_page.dart';
import 'custom_list_tile.dart';

class TracksListViewBuilder extends StatefulWidget {
  final List<SongModel> songs;
   const TracksListViewBuilder({super.key, required this.songs});

  @override
  State<TracksListViewBuilder> createState() => _TracksListViewBuilderState();
}

class _TracksListViewBuilderState extends State<TracksListViewBuilder> {


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.songs.length,
      itemBuilder: (context, index) {
        final data = widget.songs;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomListTile(
            onTap: () async {
              context
                  .read<AudioPlayerRepoCubit>()
                  .playAudio(data, context, index);
              context.read<DurationCubit>().giveDuration();
              // We wait for position and total duration to load and for sf radqius to load properly
              await Future.delayed(const Duration(milliseconds: 200));
              const PlayerPage().navigate(context);
            },
            title: data[index].title,
            subtitle: data[index].artist,
          ),
        );
      },
    );
  }
}
