import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/title_artist_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/player_page/widgets/song_player.dart';

import '../../bloc/player_bloc/play_pause_cubit.dart';
import '../../widgets/myTextWidget.dart';
import 'widgets/music_player_actions.dart';
import 'widgets/title_and_fav_icon.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(0.02.mediaW(context)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorsConsts.containerColor,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorsConsts.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SongPlayer(),
            0.05.sizeH(context),
            Padding(
              padding: EdgeInsets.all(0.04.mediaW(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<TitleArtistCubit, TitleArtistState>(
                      builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleAndFavIcon(
                          title: state.title,
                        ),
                        MyText(text: state.artist ?? "Unknown"),
                      ],
                    );
                  }),
                  0.05.sizeH(context),
                  BlocBuilder<DurationCubit, DurationState>(
                      builder: (context, state) {
                    return Center(
                        child: MyText(
                      text:
                          "${state.positionDuration.toString().split(".")[0]}  /  ${state.totalDuration.toString().split(".")[0]}",
                      size: 0.9,
                    ));
                  }),
                  0.05.sizeH(context),
                  MusicPlayerActions(
                    next: () =>
                        context.read<PlayPauseCubit>().nextSong(context),
                    previous: () =>
                        context.read<PlayPauseCubit>().prevSong(context),
                    skip10Secs: () =>
                        context.read<DurationCubit>().skip10Secs(),
                    rewind10Secs: () =>
                        context.read<DurationCubit>().rewind10Secs(),
                    playPause: () {
                      if (context.read<PlayPauseCubit>().state.isPlaying) {
                        context.read<PlayPauseCubit>().pause();
                      } else {
                        context.read<PlayPauseCubit>().resume();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
