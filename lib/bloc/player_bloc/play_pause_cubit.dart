import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

part 'play_pause_state.dart';

class PlayPauseCubit extends Cubit<ChangePlayerIconState> {
  PlayPauseCubit() : super(const ChangePlayerIconState(isPlaying: true));
  static final AudioPlayer player = AudioPlayer();

  void playAudio(String uri) async {
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(uri),
      ),
    );
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
}
