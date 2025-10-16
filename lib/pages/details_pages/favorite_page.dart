import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_music_player/constants.dart';
import 'package:copy_music_player/pages/details_pages/widgets/custom_list_tile.dart';
import 'package:copy_music_player/pages/details_pages/widgets/no_foo_found.dart';


import '../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../bloc/player_bloc/duration_cubit.dart';
import '../../favorite_song_model.dart' show FavoriteSongModel;
import '../../main.dart';
import '../../widgets/dialog.dart';
import '../../widgets/myTextWidget.dart';
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
      appBar: AppBarWidget(
        title: "Favorite",
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.mediaW(context)),
            child: GestureDetector(
              onTap: () => showDialog(
                context: context,
                builder: (context) => MyAlertDialog(
                  onYesTap: () {
                    favoriteSongsRepo.clearBox;
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  title: "Clear Favorites",
                  description:
                      "Are you sure you want to delete your favorite songs",
                ),
              ),
              child: const MyText(
                text: "Clear",
                size: 1.2,
                textColor: ColorsConsts.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: favSongs!.isEmpty
          ? const NoFooFound(text: "No favorites found")
          : ListView.builder(
              itemCount: favSongs!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomListTile(
                    onTap: () {
                      final data =
                          favSongs!.map((e) => e.toSongModelFav()).toList();
                      context
                          .read<AudioPlayerRepoCubit>()
                          .playAudio(data, context, i);
                      context.read<DurationCubit>().giveDuration();
                      const PlayerPage().navigate(context);
                    },
                    title: favSongs![i].title!,
                    subtitle: favSongs?[i].artist ?? "Unknown",
                  ),
                );
              }),
    );
  }
}
