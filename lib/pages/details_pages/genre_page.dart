import 'package:flutter/material.dart';

import 'widgets/app_bar_widget.dart';

class GenrePage extends StatelessWidget {
  const GenrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Genre",
      ),
    );
  }
}
