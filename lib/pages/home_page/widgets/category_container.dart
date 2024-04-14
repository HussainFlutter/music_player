import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/constants.dart';
import 'package:ui_challenge/widgets/myTextWidget.dart';

class CategoryContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final String items;
  final VoidCallback onTap;
  const CategoryContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 0.09.mediaH(context),
            width: 0.2.mediaW(context),
            decoration: BoxDecoration(
              color: ColorsConsts.containerColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(icon),
          ),
        ),
        MyText(
          text: title,
          size: 1,
        ),
        MyText(
          text: items,
          size: 1,
        ),
      ],
    );
  }
}
