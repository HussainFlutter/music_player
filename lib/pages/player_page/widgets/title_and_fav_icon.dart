import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:ui_challenge/bloc/favorite_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/favorite_song_model.dart';
import 'package:ui_challenge/main.dart';

import '../../../widgets/myTextWidget.dart';

class TitleAndFavIcon extends StatefulWidget {
  final SongModel songModel;
  final String title;

  const TitleAndFavIcon({
    super.key,
    required this.title,
    required this.songModel,
  });

  @override
  State<TitleAndFavIcon> createState() => _TitleAndFavIconState();
}

class _TitleAndFavIconState extends State<TitleAndFavIcon> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().isFavorite(widget.songModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: MyText(text: widget.title),
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                if (state.isFavorite) {
                  favoriteSongsRepo.removeFromFavorite(widget.songModel.id);
                  context.read<FavoriteCubit>().isFavorite(widget.songModel.id);
                } else {
                  favoriteSongsRepo.addToFavorite(
                    FavoriteSongModel(
                      id: widget.songModel.id,
                      title: widget.songModel.title,
                      artist: widget.songModel.artist,
                      data: widget.songModel.data,
                    ),
                  );
                  context.read<FavoriteCubit>().isFavorite(widget.songModel.id);
                }
              },
              icon: state.isFavorite
                  ? Icon(
                      Icons.favorite,
                      color: ColorsConsts.primaryColor,
                      size: 0.09.mediaW(context),
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: 0.09.mediaW(context),
                    ),
            );
          },
        ),
      ],
    );
  }
}
