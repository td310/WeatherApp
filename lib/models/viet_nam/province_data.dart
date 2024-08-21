class ProvinceData {
  final String name;
  final double latitude;
  final double longitude;

  ProvinceData({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory ProvinceData.fromJson(Map<String, dynamic> json) {
    return ProvinceData(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}