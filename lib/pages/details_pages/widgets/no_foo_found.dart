import 'package:flutter/material.dart';

import '../../../widgets/myTextWidget.dart';

class NoFooFound extends StatelessWidget {
  final String text;
  const NoFooFound({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyText(
        text: text,
      ),
    );
  }
}
