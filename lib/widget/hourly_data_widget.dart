import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/location_controller.dart';
import 'package:weather_app/models/weather_data_hourly.dart';
import '../utils/custom_colors.dart';
import '../utils/time_background.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyDataWidget({super.key, required this.weatherDataHourly});

  RxInt cardIndex = LocationController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: TimeBasedBackground.getBoxColor(),
        ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5,left: 7),
            alignment: Alignment.topLeft,
            child: Text(
              "Hôm Nay",
              style: TextStyle(color: TimeBasedBackground.getTextColor(), fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20,left: 7),
            height: 1,
            color: TimeBasedBackground.getTextColor(),
          ),
          hourlyList()
        ]
      )
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 13
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10,top: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.3, 2),
                          blurRadius: 7,
                          color: CustomColors.dividerLine.withAlpha(150))
                    ],
                    gradient: cardIndex.value == index ? TimeBasedBackground.getBoxColor2() : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),

              ))));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {super.key,
      required this.index,
      required this.cardIndex,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat("jm").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        )
      ],
    );
  }
}
