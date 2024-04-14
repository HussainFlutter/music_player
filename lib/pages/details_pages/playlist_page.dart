import 'package:flutter/material.dart';

import 'widgets/app_bar_widget.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Playlist",
      ),
    );
  }
}
