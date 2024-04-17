part of 'repeat_cubit.dart';

class RepeatState extends Equatable {
  final bool isRepeatingAll;
  final bool isRepeatingOne;
  const RepeatState({
    required this.isRepeatingAll,
    required this.isRepeatingOne,
  });

  @override
  List<Object?> get props => [isRepeatingAll, isRepeatingOne];
}
