part of 'shuffle_cubit.dart';

class ShuffleState extends Equatable {
  final bool isShuffling;
  const ShuffleState({required this.isShuffling});

  @override
  List<Object?> get props => [isShuffling];
}
