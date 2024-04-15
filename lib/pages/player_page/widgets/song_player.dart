import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:ui_challenge/bloc/player_bloc/duration_cubit.dart';

import '../../../constants.dart';

class SongPlayer extends StatefulWidget {
  const SongPlayer({super.key});

  @override
  State<SongPlayer> createState() => _SongPlayerState();
}

class _SongPlayerState extends State<SongPlayer> {
  //double pointerValue = 100;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DurationCubit, DurationState>(
      builder: (context, state) {
        return Center(
            child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: -1,
            maximum: state.totalDuration.inSeconds.toDouble(),
            startAngle: -1,
            endAngle: 180,
            isInversed: true,
            showTicks: false,
            showLabels: false,
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  margin: EdgeInsets.all(0.15.mediaW(context)),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AssetsConsts.playingImage),
                      fit: BoxFit.cover,
                    ),
                    color: ColorsConsts.bgColor,
                    borderRadius: BorderRadius.circular(10000000),
                  ),
                ),
              )
            ],
            ranges: [
              GaugeRange(
                startValue: -1,
                endValue: state.positionDuration.inSeconds.toDouble(),
                color: ColorsConsts.primaryColor,
              ),
            ],
            pointers: [
              MarkerPointer(
                markerType: MarkerType.diamond,
                onValueChanged: (value) =>
                    context.read<DurationCubit>().seekTo(value.toInt()),
                enableDragging: true,
                borderColor: ColorsConsts.primaryColor,
                borderWidth: 10,
                value: state.positionDuration.inSeconds.toDouble(),
              ),
            ],
          )
        ]));
      },
    );
  }
}
