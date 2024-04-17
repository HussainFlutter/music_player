import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/bloc/player_bloc/repeat_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/shuffle_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/title_artist_cubit.dart';
import 'package:ui_challenge/constants.dart';

part 'audio_player_repo_state.dart';

class AudioPlayerRepoCubit extends Cubit<ChangePlayerIconState> {
  AudioPlayerRepoCubit() : super(const ChangePlayerIconState(isPlaying: true));
  static final AudioPlayer player = AudioPlayer();
  int index = 0;
  int listLength = 0;
  void playAudio(List<SongModel> songs, BuildContext context, int i) async {
    index = i;
    listLength = songs.length;
    player.currentIndexStream.listen((event) {
      index = event!;
      context
          .read<TitleArtistCubit>()
          .giveTitleArtist(songs[event].title, songs[event].artist);
    });
    context
        .read<TitleArtistCubit>()
        .giveTitleArtist(songs[i].title, songs[i].artist);
    final List<UriAudioSource> songsList = songs
        .map(
          (e) => AudioSource.uri(
            Uri.parse(e.data),
            tag: MediaItem(
              artist: e.artist ?? "Unknown",
              id: e.id.toString(),
              title: e.title,
            ),
          ),
        )
        .toList();
    await player.setAudioSource(
      ConcatenatingAudioSource(
        children: songsList,
      ),
    );
    player.seek(const Duration(seconds: 0), index: i);
    emit(const ChangePlayerIconState(isPlaying: true));
    await player.play();
  }

  void resume() async {
    emit(const ChangePlayerIconState(isPlaying: true));
    await player.play();
  }

  void pause() async {
    emit(const ChangePlayerIconState(isPlaying: false));
    await player.pause();
  }

  void startShuffle(BuildContext context, bool shuffle) async {
    context.read<ShuffleCubit>().changeShuffle(shuffle);
    await player.setShuffleModeEnabled(shuffle);
  }

  void nextSong(BuildContext context) async {
    if (index + 1 < listLength) {
      await player.seekToNext();
    } else {
      "No song to go forward to".showSnackBar(context: context);
    }
  }

  void prevSong(BuildContext context) async {
    if (index != 0) {
      await player.seekToPrevious();
    } else {
      "No song to go back to".showSnackBar(context: context);
    }
  }

  void listenForLoopMode(BuildContext context) {
    player.loopModeStream.listen((event) {
      if (event == LoopMode.all) {
        context.read<RepeatCubit>().repeatAll();
      } else if (event == LoopMode.one) {
        context.read<RepeatCubit>().repeatOnce();
      } else if (event == LoopMode.off) {
        context.read<RepeatCubit>().repeatOff();
      }
    });
  }

  void get repeatOnce => player.setLoopMode(LoopMode.one);
  void get repeatAll => player.setLoopMode(LoopMode.all);
  void get repeatOff => player.setLoopMode(LoopMode.off);
}
