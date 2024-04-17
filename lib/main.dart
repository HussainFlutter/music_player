import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ui_challenge/bloc/player_bloc/audio_player_repo_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/repeat_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/shuffle_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/title_artist_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/splash_page.dart';

import 'bloc/song_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    //  androidStopForegroundOnPause: false,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SongBloc(),
          ),
          BlocProvider(
            create: (context) => AudioPlayerRepoCubit(),
          ),
          BlocProvider(
            create: (context) => DurationCubit(),
          ),
          BlocProvider(
            create: (context) => TitleArtistCubit(),
          ),
          BlocProvider(
            create: (context) => ShuffleCubit(),
          ),
          BlocProvider(
            create: (context) => RepeatCubit(),
          ),
        ],
        child: MaterialApp(
          theme: myAppTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
          title: "Song Player",
        ),
      ),
    );
  }

  ThemeData get myAppTheme => ThemeData(
      appBarTheme: const AppBarTheme(
        color: ColorsConsts.bgColor,
      ),
      colorScheme: const ColorScheme.dark(
        background: ColorsConsts.bgColor,
      ));
}

//Sliver AppBar and a ListViewBuilder

// CustomScrollView(
// slivers: [
// SliverAppBar(
// backgroundColor: ColorsConsts.bgColor,
// pinned: true,
// floating: true,
// centerTitle: true,
// flexibleSpace: FlexibleSpaceBar(
// centerTitle: true,
// title: Row(
// children: [
// const MyText(
// text: "MUSIC BAG",
// size: 0.8,
// ),
// 0.04.sizeW(context),
// SvgPicture.asset(width: 25, AssetsConsts.bagSvg),
// ],
// ),
// ),
// expandedHeight: 0.13.mediaH(context),
// ),
// SliverList(
// delegate: SliverChildBuilderDelegate(
// childCount: 89,
// (BuildContext context, int index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// height: 100,
// color: Colors.red,
// ),
// );
// },
// ))
// ],
// ),
