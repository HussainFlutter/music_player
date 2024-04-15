import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'title_artist_state.dart';

class TitleArtistCubit extends Cubit<TitleArtistState> {
  TitleArtistCubit() : super(const TitleArtistState(title: "", artist: ""));

  void giveTitleArtist(String title, String? artist) {
    emit(TitleArtistState(title: title, artist: artist));
  }
}
