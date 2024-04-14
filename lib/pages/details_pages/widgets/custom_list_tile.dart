import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';
import '../../../widgets/myTextWidget.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? artist;
  const CustomListTile({super.key, required this.title, required this.artist});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorsConsts.containerColor,
          borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: SvgPicture.asset(AssetsConsts.arrowSvg),
        title: MyText(
          text: title,
          maxLines: 1,
        ),
        subtitle: MyText(
          text: artist ?? "Unknown",
        ),
      ),
    );
  }
}
