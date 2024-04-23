import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/favorite_song_model.dart';
import 'package:ui_challenge/main.dart';
import 'package:ui_challenge/pages/details_pages/widgets/custom_list_tile.dart';
import 'package:ui_challenge/pages/details_pages/widgets/no_foo_found.dart';

import '../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../bloc/player_bloc/duration_cubit.dart';
import '../player_page/player_page.dart';
import 'widgets/app_bar_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({
    super.key,
  });

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final List<FavoriteSongModel>? favSongs = [];
  @override
  void initState() {
    super.initState();
    final List<FavoriteSongModel> songs = favoriteSongsRepo.box.values
        .map((e) => FavoriteSongModel.fromMap(e))
        .toList();
    favSongs?.addAll(songs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: "Favorite",
      ),
      body: favSongs!.isEmpty
          ? const NoFooFound(text: "No favorites found")
          : ListView.builder(
              itemCount: favSongs!.length,
              itemBuilder: (context, i) {
                return CustomListTile(
                  onTap: () {
                    final data =
                        favSongs!.map((e) => e.toSongModelFav()).toList();
                    context
                        .read<AudioPlayerRepoCubit>()
                        .playAudio(data, context, i);
                    context.read<DurationCubit>().giveDuration();
                    PlayerPage(
                      songModel: data[i],
                    ).navigate(context);
                  },
                  title: favSongs![i].title!,
                  subtitle: favSongs?[i].artist ?? "Unknown",
                );
              }),
    );
  }
}
