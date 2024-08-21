import 'package:flutter/material.dart';
class TimeBasedBackground {

  static const colorNight1 = Color(0xff3E2D8F);
  static const colorNight2 = Color(0xff9D52AC);

  static const colorNight3 = Color(0xff4f37b0);
  static const colorNight4 = Color(0xffcb6ade);
  static const colorNight5 = Color(0xff8E78C8);

  static const colorBlue1 = Color(0xff8cb0e5);
  static const colorBlue2 = Color(0xff5079ce);

  static const colorDay1 = Color(0xffFFE9D0);
  static const colorDay2 = Color(0xffFEFFD2);

  static bool isDaytime() {
    final currentHour = DateTime.now().hour;
    return currentHour >= 6 && currentHour < 18;
  }

  static LinearGradient getBackgroundGradient() {
    return LinearGradient(
      colors: isDaytime()
          ? [Colors.blue.shade200,Colors.yellow.shade300]
          : [colorNight1,colorNight1, colorNight2],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }

  static Color getTextColor(){
    return isDaytime() ? Colors.blue.shade800 : Colors.grey.shade300;
  }

  static Color getTextColor2(){
    return isDaytime() ? colorBlue2 : colorNight1;
  }

  static Color getTextColor3(){
    return isDaytime() ? colorBlue1 : colorNight5;
  }

  static LinearGradient getBoxColor(){
    return LinearGradient(
      colors: isDaytime()
          ? [colorDay1.withAlpha(160),colorDay2.withAlpha(160)]
          : [colorNight3.withAlpha(120), colorNight4.withAlpha(120)],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
    );
  }

  static LinearGradient getBoxColor2(){
    return LinearGradient(
      colors: isDaytime()
          ? [colorBlue1,colorBlue2]
          : [colorNight3, colorNight5],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
    );
  }
}
