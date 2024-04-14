import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';
import 'package:ui_challenge/bloc/player_bloc/play_pause_cubit.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/pages/splash_page.dart';

import 'bloc/song_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            create: (context) => PlayPauseCubit(),
          ),
          BlocProvider(
            create: (context) => DurationCubit(),
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
