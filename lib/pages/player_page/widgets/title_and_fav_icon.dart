import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_challenge/bloc/favorite_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/audio_player_repo_cubit.dart';
import 'package:ui_challenge/constants.dart';

import '../../../widgets/myTextWidget.dart';

class TitleAndFavIcon extends StatefulWidget {
  final String title;

  const TitleAndFavIcon({
    super.key,
    required this.title,
  });

  @override
  State<TitleAndFavIcon> createState() => _TitleAndFavIconState();
}

class _TitleAndFavIconState extends State<TitleAndFavIcon> {
  @override
  void initState() {
    super.initState();
    context.read<AudioPlayerRepoCubit>().isFavorite(context);
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
                  // Do remove
                  context.read<AudioPlayerRepoCubit>().removeFromFavoritesList;
                  context.read<AudioPlayerRepoCubit>().isFavorite(context);
                } else {
                  context.read<AudioPlayerRepoCubit>().addToFavorite;
                  context.read<AudioPlayerRepoCubit>().isFavorite(context);
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
