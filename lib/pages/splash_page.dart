import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ui_challenge/bloc/song_bloc.dart';
import 'package:ui_challenge/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SongBloc>().add(GetSongsEvent(context: context));
    //print(context.read<SongsLoaded>().songs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsConsts.bagSvg,
            ),
            0.04.sizeH(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.2.mediaW(context)),
              child: const LinearProgressIndicator(
                color: ColorsConsts.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
