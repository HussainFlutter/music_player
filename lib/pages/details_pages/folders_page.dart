import 'package:flutter/material.dart';

import 'widgets/app_bar_widget.dart';

class FoldersPage extends StatelessWidget {
  const FoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Folders",
      ),
    );
  }
}
