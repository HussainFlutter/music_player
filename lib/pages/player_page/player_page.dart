import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/repeat_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/shuffle_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/title_artist_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/player_page/widgets/song_player.dart';

import '../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../widgets/myTextWidget.dart';
import 'widgets/music_player_actions.dart';
import 'widgets/title_and_fav_icon.dart';

class PlayerPage extends StatefulWidget {
  final SongModel songModel;
  const PlayerPage({super.key, required this.songModel});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  void initState() {
    super.initState();
    context.read<AudioPlayerRepoCubit>().listenForLoopMode(context);
  }

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
                          songModel: widget.songModel,
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
                        context.read<AudioPlayerRepoCubit>().nextSong(context),
                    previous: () =>
                        context.read<AudioPlayerRepoCubit>().prevSong(context),
                    skip10Secs: () =>
                        context.read<DurationCubit>().skip10Secs(),
                    rewind10Secs: () =>
                        context.read<DurationCubit>().rewind10Secs(),
                    playPause: () {
                      if (context
                          .read<AudioPlayerRepoCubit>()
                          .state
                          .isPlaying) {
                        context.read<AudioPlayerRepoCubit>().pause;
                      } else {
                        context.read<AudioPlayerRepoCubit>().resume;
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<RepeatCubit, RepeatState>(builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<ShuffleCubit, ShuffleState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () => context
                        .read<AudioPlayerRepoCubit>()
                        .startShuffle(context, !state.isShuffling),
                    icon: Icon(
                      Icons.shuffle,
                      color: state.isShuffling
                          ? ColorsConsts.primaryColor
                          : ColorsConsts.textColor,
                    ));
              },
            ),
            IconButton(
                onPressed: () => state.isRepeatingAll
                    ? context.read<AudioPlayerRepoCubit>().repeatOff
                    : context.read<AudioPlayerRepoCubit>().repeatAll,
                icon: Icon(
                  Icons.repeat,
                  color: state.isRepeatingAll
                      ? ColorsConsts.primaryColor
                      : ColorsConsts.textColor,
                )),
            IconButton(
              onPressed: () => state.isRepeatingOne
                  ? context.read<AudioPlayerRepoCubit>().repeatOff
                  : context.read<AudioPlayerRepoCubit>().repeatOnce,
              icon: Icon(
                Icons.repeat_one,
                color: state.isRepeatingOne
                    ? ColorsConsts.primaryColor
                    : ColorsConsts.textColor,
              ),
            ),
          ],
        );
      }),
    );
  }
}
