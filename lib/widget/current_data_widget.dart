import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/weather_data_current.dart';

import '../utils/custom_colors.dart';
import '../utils/time_background.dart';

class CurrentDataWidget extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentDataWidget({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(),
        Text(
          "${weatherDataCurrent.current.weather![0].description}".toUpperCase(),
          style: GoogleFonts.robotoSlab(
            color: TimeBasedBackground.getTextColor(),
            fontSize: 15,
            height: 2,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        currentWeatherDetailWidget(),
      ],
    );
  }

  Widget currentWeatherDetailWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Image.asset("assets/icons/icon_atmospheric_pressure.png"),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.windSpeed}km/h",
                style: TextStyle(
                    fontSize: 12,
                    color: TimeBasedBackground.getTextColor()
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.clouds}%",
                style: TextStyle(
                    fontSize: 12,
                    color: TimeBasedBackground.getTextColor()
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                "${weatherDataCurrent.current.pressure} hPa",
                style: TextStyle(
                    fontSize: 12,
                    color: TimeBasedBackground.getTextColor(),
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        Text(
          "${weatherDataCurrent.current.temp!.toInt()}°",
            style: GoogleFonts.robotoSlab(
              fontWeight: FontWeight.w400,
              fontSize: 68,
              color: TimeBasedBackground.getTextColor(),
            ),

        ),
      ],
    );
  }
}
