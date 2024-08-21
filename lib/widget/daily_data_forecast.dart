import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/utils/custom_colors.dart';

import '../utils/time_background.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  DailyDataForecast({super.key, required this.weatherDataDaily}){
    initializeDateFormatting('vi', null);
  }

  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat("EEE", "vi").format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: TimeBasedBackground.getBoxColor(),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 25,left: 10),
            alignment: Alignment.topLeft,
            child: Text(
              "Dự báo ngày tới",
              style: TextStyle(color: TimeBasedBackground.getTextColor(), fontSize: 17),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList(){
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7 ? 7: weatherDataDaily.daily.length,
        itemBuilder: (context, index){
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 1,
                color: TimeBasedBackground.getTextColor(),
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: TextStyle(
                          color: TimeBasedBackground.getTextColor(), fontSize: 18),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png")
                    ),
                    Text(
                      "${weatherDataDaily.daily[index].temp!.min}°/${weatherDataDaily.daily[index].temp!.max}°",
                      style: TextStyle(
                        color: TimeBasedBackground.getTextColor(), fontSize: 18
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
