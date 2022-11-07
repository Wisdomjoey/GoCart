import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // Dynamic values for slide view
  // static double pageView = screenHeight / 2.578125;
  static double pageViewContainer = screenHeight / 4.49444444444;

  // Dynamic height, padding and margin
  static double sizedBoxHeight10 = screenHeight / 80.9;
  static double sizedBoxHeight15 = screenHeight / 53.93333333333;
  static double sizedBoxHeight20 = screenHeight / 40.45;
  static double sizedBoxHeight30 = screenHeight / 26.966666666667;
  static double sizedBoxHeight45 = screenHeight / 17.977777777778;
  static double sizedBoxHeight100 = screenHeight / 8.09;
  static double sizedBoxHeight120 = screenHeight / 6.74166666666667;
  static double sizedBoxHeight350 = screenHeight / 2.311428571428571;

  // Dynamic Width, padding and margin
  static double sizedBoxWidth10 = screenWidth / 36;
  static double sizedBoxWidth15 = screenWidth / 24;
  static double sizedBoxWidth20 = screenWidth / 18;
  static double sizedBoxWidth30 = screenWidth / 12;
  static double sizedBoxWidth45 = screenWidth / 8;
  static double sizedBoxWidth120 = screenWidth / 3;

  // Dynamic font and border radius
  static double font16 = screenHeight / 22.5;
  static double font20 = screenHeight / 18;
  static double font26 = screenHeight / 13.84615384615385;
  static double radius5 = screenHeight / 72;
  static double radius15 = screenHeight / 24;
  static double radius20 = screenHeight / 18;
  static double radius30 = screenHeight / 12;

  // Dynamic icon
  static double iconSize24 = screenWidth / 15;
  static double iconSize16 = screenWidth / 22.5;
}
