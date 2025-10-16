import 'package:flutter/material.dart';
import 'package:copy_music_player/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/myTextWidget.dart';

class GivePermissionPage extends StatelessWidget {
  const GivePermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: const MyText(
                text:
                    "This app needs storage permission to work. Please give storage permission to this app and restart the app",
              ),
            ),
            0.03.sizeH(context),
   
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConsts.containerColor,
              ),
              onPressed: () async {
                  const storagePermission = Permission.storage;
                   await storagePermission.request();
                   await Permission.audio.request();
                   await Permission.manageExternalStorage.request();
              },
              child: const MyText(text: "Ask Permission"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsConsts.containerColor,
              ),
              onPressed: () => openAppSettings(),
              child: const MyText(text: "Open Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
