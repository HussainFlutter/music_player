import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ui_challenge/main.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(const FavoriteState(isFavorite: false));
  void isFavorite(int id) {
    if (favoriteSongsRepo.box.keys.contains(id)) {
      emit(const FavoriteState(isFavorite: true));
    } else {
      emit(const FavoriteState(isFavorite: false));
    }
  }
}
