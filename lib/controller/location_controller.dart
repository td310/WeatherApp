import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/models/weather_data.dart';

import '../api/province_service.dart';
import '../models/viet_nam/province_data.dart';

class LocationController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;
  final weatherData = WeatherData().obs;

  final RxList<ProvinceData> _provinces = <ProvinceData>[].obs;
  List<ProvinceData> get provinces => _provinces;

  RxBool checkLoading() => _isLoading;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  RxInt getIndex() {
    return _currentIndex;
  }

  WeatherData getData() {
    return weatherData.value;
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    try {
      final weather = await FetchWeatherApi().processData(lat, lon);
      weatherData.value = weather;
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProvinces();
    if (_isLoading.isTrue) {
      getCurrentLocation();
    } else {
      getIndex();
    }
  }

  Future<void> loadProvinces() async {
    final provinces = await DataService().loadProvinces();
    _provinces.assignAll(provinces);
  }

  void updateLocationFromProvince(ProvinceData province) {
    _latitude.value = province.latitude;
    _longitude.value = province.longitude;
    fetchWeatherData(province.latitude, province.longitude);
  }

  Future<void> getCurrentLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      throw Exception("Location services are disabled.");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _latitude.value = position.latitude;
    _longitude.value = position.longitude;

    fetchWeatherData(position.latitude, position.longitude);
  }

}

