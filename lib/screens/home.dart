import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/location_controller.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widget/comfort_level_widget.dart';
import 'package:weather_app/widget/current_data_widget.dart';
import 'package:weather_app/widget/daily_data_forecast.dart';
import 'package:weather_app/widget/header_widget.dart';
import 'package:weather_app/widget/hourly_data_widget.dart';

import '../utils/time_background.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LocationController locationCL =
      Get.put(LocationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => locationCL.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/icon_cloud.png",
                      height: 200,
                      width: 200,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  gradient: TimeBasedBackground.getBackgroundGradient(),
                ),
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const HeaderWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      CurrentDataWidget(
                        weatherDataCurrent:
                            locationCL.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly:
                            locationCL.getData().getHourlyWeather(),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      DailyDataForecast(
                        weatherDataDaily:
                            locationCL.getData().getDailyWeather(),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      ComfortLevelWidget(
                        weatherDataCurrent:
                            locationCL.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )),
      ),
    );
  }
}
