import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  // Neutral Colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Semantic colors

  static const Color main = Colors.teal;
  static const Color backgroundColor = Color(0xFFFAF8FF);
  static const Color grey1 = Color.fromARGB(255, 223, 220, 220);
  static const Color grey2 = Color(0xFFF6F6F6);
  static const Color grey3 = Color(0xFFF9F9F9);
  static const Color lightgrey = Color(0xFFF2F4F7);
  static const Color danger = Color(0xFFFF0000);
  static const Color laight1Danger = Color(0xFFBC004B);
  static const Color laight2Danger = Color(0xFFFECDCA);
  static const Color yallow = Color(0xFFFDA036);
  static const Color laightYallow = Color(0xFFFFF9F3);
  static const Color boldGreen = Color(0xFF067647);
  static const Color laightGreen = Color(0xFFABEFC6);
  static const Color laightblue = Color(0xFFEFF0F7);
  static const Color darkGrey = Color(0xFF4B5563);
  static const Color darkRed = Color(0xFFAE2620);

  // Order Status colors
  static const Color processingProgressTextColor = Color(0xFF026AA2); // ID 2
  static const Color processingProgressBackgroundColor =
      Color(0xFFB9E6FE); // ID 2
  static const Color processingTextColor = Color(0xFFB54708); // ID 3
  static const Color processingBackgroundColor = Color(0xFFFEDF89); // ID 3
  static const Color implementedDoneTextColor = Color(0xFF5925DC); // ID 4
  static const Color implementedDoneBackgroundColor = Color(0xFFD9D6FE); // ID 4
  static const Color deliveryProgressTextColor = Color(0xFF363F72); // ID 5
  static const Color deliveryProgressBackgroundColor =
      Color(0xFFD5D9EB); // ID 5
  static const Color completeTextColor = Color(0xFF067647); // ID 6
  static const Color completeBackgroundColor = Color(0xFFABEFC6); // ID 6
  static const Color cancelTextColor = Color(0xFFB42318); // ID 8
  static const Color cancelBackgroundColor = Color(0xFFFECDCA); // ID 8

  static orderStatusMainColor(int status) {
    switch (status) {
      case 2:
        return processingProgressTextColor;
      case 3:
        return processingTextColor;
      case 4:
        return implementedDoneTextColor;
      case 5:
        return deliveryProgressTextColor;
      case 6:
        return completeTextColor;
      case 7:
        return cancelTextColor;
      case 8:
        return cancelTextColor;
      default:
        return Colors.grey;
    }
  }

  static orderStatusSecondColor(int status) {
    Color color = Colors.white;
    switch (status) {
      case 2:
        color = processingProgressBackgroundColor;
      case 3:
        color = processingBackgroundColor;
      case 4:
        color = implementedDoneBackgroundColor;
      case 5:
        color = deliveryProgressBackgroundColor;
      case 6:
        color = completeBackgroundColor;
      case 7:
        color = cancelBackgroundColor;
      case 8:
        color = cancelBackgroundColor;
      default:
        color = Colors.white;
    }
    return color.withOpacity(0.3);
  }
}
