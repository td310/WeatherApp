import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';

import '../utils/time_background.dart';

class ComfortLevelWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const ComfortLevelWidget({super.key, required this.weatherDataCurrent});

  String getUvLevel(double uvIndex) {
    if (uvIndex <= 2) {
      return "Thấp";
    } else if (uvIndex <= 5) {
      return "Trung Bình";
    } else if (uvIndex <= 7) {
      return "Cao";
    } else {
      return "Rất Cao";
    }
  }

  String getUvAdvice(double uvIndex) {
    if (uvIndex <= 2) {
      return "Hiện tại đang ở Mức Thấp";
    } else if (uvIndex <= 7) {
      return "Nên sử dụng biện pháp tránh nắng";
    } else {
      return "Hạn chế ở ngoài trời lâu";
    }
  }

  @override
  Widget build(BuildContext context) {
    double uvIndex = weatherDataCurrent.current.uvIndex!.toDouble();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: TimeBasedBackground.getBoxColor(),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Cảm nhận",
                    style: TextStyle(fontSize: 18, color: TimeBasedBackground.getTextColor()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      initialValue:
                          weatherDataCurrent.current.humidity!.toDouble(),
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                              handlerSize: 4,
                              trackWidth: 13,
                              progressBarWidth: 13),
                          infoProperties: InfoProperties(
                              bottomLabelText: "Độ Ẩm",
                              bottomLabelStyle: TextStyle(
                                  color:  TimeBasedBackground.getTextColor(),
                                  letterSpacing: 0.1,
                                  fontSize: 18,
                                  height: 1.5)),
                          animationEnabled: true,
                          size: 130,
                          customColors: CustomSliderColors(
                              hideShadow: true,
                              trackColor: CustomColors.firstGradientColor.withAlpha(100),
                              progressBarColors: [
                                TimeBasedBackground.getTextColor3().withAlpha(100),
                                TimeBasedBackground.getTextColor2()
                              ])),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: TimeBasedBackground.getBoxColor(),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Mức độ UV",
                    style: TextStyle(
                        fontSize: 18,
                        color: TimeBasedBackground.getTextColor()),
                  ),
                  Text(getUvLevel(uvIndex),
                    style: TextStyle(
                        fontSize: 18,
                        color: TimeBasedBackground.getTextColor()),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1700,
                      barRadius: const Radius.circular(50),
                      lineHeight: 20,
                      percent: (uvIndex / 100)
                          .clamp(0.0, 1.0),
                      center:
                          Text("${uvIndex / 10}", style: TextStyle( color:  TimeBasedBackground.getTextColor()),),
                      backgroundColor: TimeBasedBackground.getTextColor3().withAlpha(100),
                      progressColor: TimeBasedBackground.getTextColor2(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,right: 15,left: 15),
                    child: Text(
                      getUvAdvice(uvIndex),
                      style: TextStyle(
                          fontSize: 16,
                          color: TimeBasedBackground.getTextColor()),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
