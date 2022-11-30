import 'package:flutter/material.dart';

class ScreenSize {
  static double screenWidth = 0;
  static double screenHeight = 0;

  initializeSizes(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }
}
