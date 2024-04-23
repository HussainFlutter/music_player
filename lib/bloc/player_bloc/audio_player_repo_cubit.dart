import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/bloc/favorite_cubit.dart';
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
    try {
      index = i;
      listLength = songs.length;
      listenForPlayerState();
      player.currentIndexStream.listen((event) {
        index = event ?? 0;
        context
            .read<TitleArtistCubit>()
            .giveTitleArtist(songs[event ?? 0].title, songs[event ?? 0].artist);
        final id = player.audioSource?.sequence[index].tag as MediaItem;
        context.read<FavoriteCubit>().isFavorite(int.parse(id.id));
      });
      context
          .read<TitleArtistCubit>()
          .giveTitleArtist(songs[i].title, songs[i].artist);
      //print(songs);
      final List<UriAudioSource> songsList = songs.map((e) {
        // print(e.data);
        // print(e.artist);
        // print(e.id);
        //  print(e.title);
        return AudioSource.uri(
          Uri.parse(e.data),
          tag: MediaItem(
            artist: e.artist ?? "Unknown",
            id: e.id.toString(),
            title: e.title,
          ),
        );
      }).toList();
      await player.setAudioSource(
        ConcatenatingAudioSource(
          children: songsList,
        ),
      );
      player.seek(const Duration(seconds: 0), index: i);
      emit(const ChangePlayerIconState(isPlaying: true));
      await player.play();
    } catch (e) {
      debugPrint(e.toString());
    }
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

  void listenForPlayerState() {
    player.playerStateStream.listen((event) {
      emit(ChangePlayerIconState(isPlaying: event.playing));
    });
  }

  void get repeatOnce => player.setLoopMode(LoopMode.one);
  void get repeatAll => player.setLoopMode(LoopMode.all);
  void get repeatOff => player.setLoopMode(LoopMode.off);
  void get resume async => await player.play();
  void get pause async => await player.pause();
}
