import 'package:flutter/material.dart';
import 'package:copy_music_player/constants.dart';
import 'package:copy_music_player/widgets/myTextWidget.dart';


class MyAlertDialog extends StatelessWidget {
  final VoidCallback onYesTap;
  final String title;
  final String description;
  const MyAlertDialog({
    super.key,
    required this.onYesTap,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.mediaW(context)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onYesTap,
                child: const MyText(
                  text: "Yes",
                  textColor: ColorsConsts.primaryColor,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child:  const MyText(text: "No",textColor: ColorsConsts.primaryColor,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
