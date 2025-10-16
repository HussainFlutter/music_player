import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../bloc/player_bloc/audio_player_repo_cubit.dart';
import '../../../constants.dart';

class MusicPlayerActions extends StatelessWidget {
  final VoidCallback next;
  final VoidCallback previous;
  final VoidCallback skip10Secs;
  final VoidCallback rewind10Secs;
  final VoidCallback playPause;

  const MusicPlayerActions({
    super.key,
    required this.next,
    required this.previous,
    required this.skip10Secs,
    required this.rewind10Secs,
    required this.playPause,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: previous,
          child: SvgPicture.asset(
            AssetsConsts.playLeftSvg,
          ),
        ),
        IconButton(
            onPressed: rewind10Secs,
            icon: Icon(
              Icons.keyboard_double_arrow_left,
              size: 0.1.mediaW(context),
            )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: ColorsConsts.primaryColor,
          ),
          child: BlocBuilder<AudioPlayerRepoCubit, ChangePlayerIconState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: playPause,
                  icon: Icon(
                    state.isPlaying
                        ? Icons.pause_sharp
                        : Icons.play_arrow_outlined,
                    size: 0.1.mediaW(context),
                  ));
            },
          ),
        ),
        IconButton(
            onPressed: skip10Secs,
            icon: Icon(
              Icons.keyboard_double_arrow_right,
              size: 0.1.mediaW(context),
            )),
        InkWell(
          onTap: next,
          child: SvgPicture.asset(
            AssetsConsts.playRightSvg,
          ),
        ),
      ],
    );
  }
}
