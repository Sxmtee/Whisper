import 'package:flutter/material.dart';

class Dimensions {
  //screen height used = 752
  //screen width is 360

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight = 752;
  static double screenWidth = 360;
}
