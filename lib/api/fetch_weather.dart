import 'dart:convert';

import 'package:weather_app/api/api_key.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weather_data_daily.dart';
import 'package:weather_app/models/weather_data_hourly.dart';

class FetchWeatherApi{
  WeatherData? weatherData;

  Future<WeatherData> processData(lat,long) async{
    var response = await http.get(Uri.parse(apiUrl(lat, long)));
    var jsonString = jsonDecode(response.body);

    weatherData = WeatherData(

        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}

String apiUrl(var lat, var long){
  String url;
  url = "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$apiKey&units=metric&lang=vi";
  return url;
}