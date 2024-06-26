import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ui_challenge/bloc/player_bloc/audio_player_repo_cubit.dart';

part 'duration_state.dart';

class DurationCubit extends Cubit<DurationState> {
  DurationCubit()
      : super(const DurationState(
          positionDuration: Duration.zero,
          totalDuration: Duration.zero,
        ));
  final AudioPlayer player = AudioPlayerRepoCubit.player;
  void giveDuration() {
    player.positionStream.listen((event) {
      emit(
        DurationState(
          positionDuration: event,
          totalDuration: player.duration ?? Duration.zero,
        ),
      );
    });
  }

  void seekTo(int seconds) async {
    await player.seek(Duration(seconds: seconds));
  }

  void skip10Secs() async {
    await player.seek(Duration(seconds: player.position.inSeconds + 10));
  }

  void rewind10Secs() async {
    await player.seek(Duration(seconds: player.position.inSeconds - 10));
  }
}
