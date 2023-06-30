import 'package:google_maps_flutter/google_maps_flutter.dart';

class Geometry {
  String type;
  List<LatLng> coordinates;

  Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    List<LatLng> coordinates = [];
    for (var item in json['coordinates']) {
      coordinates.add(LatLng(item[0], item[1]));
    }
    return Geometry(
      type: json['type'],
      coordinates: coordinates,
    );
  }
}

class ServiceModel {
  Geometry geometry;

  ServiceModel({required this.geometry});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      geometry: Geometry.fromJson(json['features'][0]['geometry']),
    );
  }
}
