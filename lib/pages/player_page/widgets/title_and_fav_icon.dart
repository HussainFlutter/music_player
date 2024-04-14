import 'package:flutter/material.dart';
import 'package:ui_challenge/constants.dart';

import '../../../widgets/myTextWidget.dart';

class TitleAndFavIcon extends StatelessWidget {
  final String title;
  const TitleAndFavIcon({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: MyText(text: title),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
            size: 0.09.mediaW(context),
          ),
        ),
      ],
    );
  }
}
