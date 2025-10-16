import 'package:flutter/material.dart';

import '../constants.dart';

class MyText extends StatelessWidget {
  final String text;
  final double size;
  final double letterSpacing;
  final bool isBold;
  final int? maxLines;
  final Color textColor;
  const MyText({
    super.key,
    required this.text,
    this.size = 1,
    this.maxLines,
    this.isBold = false,
    this.letterSpacing = 0,
    this.textColor = ColorsConsts.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.linear(size),
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
