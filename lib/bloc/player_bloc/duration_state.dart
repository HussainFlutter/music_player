part of 'duration_cubit.dart';

class DurationState extends Equatable {
  final Duration totalDuration;
  final Duration positionDuration;
  const DurationState({
    required this.positionDuration,
    required this.totalDuration,
  });

  @override
  List<Object?> get props => [totalDuration, positionDuration];
}
