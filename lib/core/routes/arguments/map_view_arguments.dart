class MapViewArguments {
  final num lat;
  final num long;

  MapViewArguments({required this.lat, required this.long});

  factory MapViewArguments.fromJson(Map<String, dynamic> json) {
    return MapViewArguments(
      lat: json['lat'] as num,
      long: json['long'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
