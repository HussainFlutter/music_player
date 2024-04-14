import 'package:flutter/material.dart';

class AssetsConsts {
  static const bagSvg = "assets/image_assets/bag_icon.svg";
  static const playingImage = "assets/image_assets/playing_image.jpg";
  static const playLeftSvg = "assets/image_assets/left_arrow.svg";
  static const playRightSvg = "assets/image_assets/right_arrow.svg";
  static const arrowSvg = "assets/image_assets/arrow.svg";
}

class ColorsConsts {
  static const bgColor = Color(0xff191B28);
  static const primaryColor = Color(0xffFF9900);
  static const containerColor = Color(0xff34374B);
  static const textColor = Color(0xff9E9E9E);
}

extension MediaHeight on double {
  double mediaH(BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }
}

extension MediaWidth on double {
  double mediaW(BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}

// SizedBox extension

extension SizeVertical on double {
  Widget sizeH(BuildContext context) {
    return SizedBox(
      height: mediaH(context),
    );
  }
}

extension SizeHorizontal on double {
  Widget sizeW(BuildContext context) {
    return SizedBox(
      width: mediaW(context),
    );
  }
}

extension Navigate on Widget {
  void navigate(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => this));
}

void customPrint({required String message}) {
  debugPrint("----------------- DEBUG PRINT START ----------------");
  debugPrint("----------------------------------------------------");
  debugPrint("----------------------------------------------------");
  debugPrint(message);
  debugPrint("----------------------------------------------------");
  debugPrint("----------------------------------------------------");
  debugPrint("----------------- DEBUG PRINT END ------------------");
}
