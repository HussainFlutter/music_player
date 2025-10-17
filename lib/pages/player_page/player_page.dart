import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_music_player/pages/player_page/widgets/song_player.dart';
import '../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../bloc/player_bloc/duration_cubit.dart';
import '../../bloc/player_bloc/repeat_cubit.dart';
import '../../bloc/player_bloc/shuffle_cubit.dart';
import '../../bloc/player_bloc/title_artist_cubit.dart';
import '../../constants.dart';
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
                    onPressed: () {
                      context
                          .read<AudioPlayerRepoCubit>()
                          .startShuffle(context, !state.isShuffling);
                      if(!state.isShuffling)
                        {
                          "Shuffle On".showSnackBar(context: context);
                        }
                      else{
                        "Shuffle Off".showSnackBar(context: context);
                      }
                    },
                    icon: Icon(
                      Icons.shuffle,
                      color: state.isShuffling
                          ? ColorsConsts.primaryColor
                          : ColorsConsts.textColor,
                    ));
              },
            ),
            IconButton(
                onPressed: () {
                  if(state.isRepeatingAll)
                    {
                      context.read<AudioPlayerRepoCubit>().repeatOff;
                      "Repeating Off".showSnackBar(context: context);
                    }
                  else{
                    context.read<AudioPlayerRepoCubit>().repeatAll;
                    "Repeating All".showSnackBar(context: context);
                  }
                },
                icon: Icon(
                  Icons.repeat,
                  color: state.isRepeatingAll
                      ? ColorsConsts.primaryColor
                      : ColorsConsts.textColor,
                )),
            IconButton(
              onPressed: () {
                if(state.isRepeatingOne)
                  {
                    context.read<AudioPlayerRepoCubit>().repeatOff;
                    "Repeating Off".showSnackBar(context: context);
                  }
                else{
                  context.read<AudioPlayerRepoCubit>().repeatOnce;
                  "Repeating One".showSnackBar(context: context);
                }
              },
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
