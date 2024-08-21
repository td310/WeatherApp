import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/viet_nam/province_data.dart';

class DataService {
  Future<List<ProvinceData>> loadProvinces() async {
    final jsonString = await rootBundle.loadString('assets/viet_nam.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => ProvinceData.fromJson(json)).toList();
  }
}
