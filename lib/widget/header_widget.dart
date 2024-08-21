import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/time_background.dart';
import '../controller/location_controller.dart';
import '../models/viet_nam/province_data.dart';
import '../models/weather_data_current.dart';
import '../utils/custom_colors.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = "";
  String country = "Việt Nam";
  final LocationController locationCL =
      Get.put(LocationController(), permanent: true);

  ProvinceData? selectedProvince;

  void _updateLocation() {
    final province = locationCL.provinces.firstWhereOrNull((province) {
      return province.latitude == locationCL.getLatitude().value &&
          province.longitude == locationCL.getLongitude().value;
    });

    setState(() {
      if (province != null) {
        selectedProvince = province;
        city = province.name;
      } else {
        selectedProvince = null;
        city = "";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                city,
                style: GoogleFonts.robotoSlab(
                  color: TimeBasedBackground.getTextColor(),
                  fontSize: 30,
                  height: 2,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 23,
                width: 2,
                color: TimeBasedBackground.getTextColor(),
              ),
              Text(
                country,
                style: GoogleFonts.robotoSlab(
                  fontSize: 30,
                  height: 2,
                  color: TimeBasedBackground.getTextColor(),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownButtonFormField2<ProvinceData>(
              value: selectedProvince,
              hint: const Text("Chọn Tỉnh Thành"),
              decoration: InputDecoration(
                filled: true,
                fillColor: CustomColors.textColorGrey01,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: CustomColors.thirdGradientColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: CustomColors.thirdGradientColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: CustomColors.thirdGradientColor,
                  ),
                ),
              ),
              items: locationCL.provinces.map((ProvinceData province) {
                return DropdownMenuItem<ProvinceData>(
                  value: province,
                  child: Text(
                    province.name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: CustomColors.textColorGrey03,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (ProvinceData? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedProvince = newValue;
                    city = newValue.name;
                    locationCL.updateLocationFromProvince(newValue);
                  });
                }
              },
              dropdownStyleData: DropdownStyleData(
                maxHeight: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ), // Make dropdown wider to fit screen
            ),
          ),
        ),
      ],
    );
  }
}
