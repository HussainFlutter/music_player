import 'package:flutter/material.dart';
import 'package:ui_challenge/pages/details_pages/widgets/app_bar_widget.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Albums",
      ),
    );
  }
}
