import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride/presentation/utils/model.dart';

class SafeRideService {
  String baseURL = "";


  Future<List<LatLng>?> getRouteCoordinates(LatLng l1, LatLng l2) async {
    var response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      final temp = ServiceModel.fromJson(jsonDecode(response.body));
      return temp.geometry.coordinates;
    } else {
      throw Exception('Failed to load route');
    }
  }
}
