import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:copy_music_player/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widgets/myTextWidget.dart';
import '../details_pages/albums_page.dart';
import '../details_pages/artists_page.dart';
import '../details_pages/favorite_page.dart';
import '../details_pages/genre_page.dart';
import '../details_pages/playlist_page.dart';
import '../details_pages/tracks_page.dart';
import 'widgets/category_container.dart';

class HomePage extends StatefulWidget {
  final List<SongModel>? songs;
  final List<AlbumModel>? albums;
  final List<ArtistModel>? artists;
  final List<GenreModel>? genres;
  final List<PlaylistModel>? playlists;

  const HomePage({
    super.key,
    required this.songs,
    required this.albums,
    required this.artists,
    required this.genres,
    required this.playlists,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(width: 25, AssetsConsts.bagSvg),
            0.04.sizeW(context),
            const MyText(
              text: "MUSICO",
              size: 1,
              isBold: true,
              letterSpacing: 2,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            0.04.sizeH(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryContainer(
                  icon: Icons.audiotrack_sharp,
                  title: "Tracks",
                  onTap: () => TracksPage(
                    songs: widget.songs,
                  ).navigate(context),
                  items: widget.songs?.length.toString() ?? "0",
                ),
                CategoryContainer(
                  items: widget.albums?.length.toString() ?? "0",
                  icon: Icons.album,
                  title: "Albums",
                  onTap: () => AlbumsPage(
                    albums: widget.albums,
                    songs: widget.songs,
                  ).navigate(context),
                ),
                CategoryContainer(
                  items: widget.artists?.length.toString() ?? "0",
                  icon: Icons.person,
                  title: "Artists",
                  onTap: () => ArtistsPage(
                    artists: widget.artists,
                    songs: widget.songs,
                  ).navigate(context),
                ),
              ],
            ),
            0.05.sizeH(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CategoryContainer(
                  items: widget.genres?.length.toString() ?? "0",
                  icon: Icons.queue_music,
                  title: "Genres",
                  onTap: () => GenrePage(
                    genreList: widget.genres,
                    songs: widget.songs,
                  ).navigate(context),
                ),
                CategoryContainer(
                  items: widget.albums?.length.toString() ?? "0",
                  icon: Icons.folder,
                  title: "Folders",
                  onTap: () => AlbumsPage(
                    folder: "Folders",
                    albums: widget.albums,
                    songs: widget.songs,
                  ).navigate(context),
                ),
                CategoryContainer(
                  items: "",
                  icon: Icons.favorite_border,
                  title: "Favorite",
                  onTap: () => const FavoritePage().navigate(context),
                ),
              ],
            ),
            0.01.sizeH(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryContainer(
                  items: widget.playlists?.length.toString() ?? "0",
                  icon: Icons.audiotrack_sharp,
                  title: "Playlists",
                  onTap: () => PlaylistPage(
                    playLists: widget.playlists,
                    songs: widget.songs,
                  ).navigate(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
