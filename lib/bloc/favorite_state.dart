part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  final bool isFavorite;
  const FavoriteState({required this.isFavorite});

  @override
  List<Object?> get props => [isFavorite];
}
