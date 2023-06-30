import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safe_ride/presentation/utils/model.dart';

class SafeRideService {
  String baseURL = "https://1ffe-38-25-30-101.ngrok-free.app/api/compute-route";

  String getRouteURL(LatLng l1, LatLng l2) {
    // return "$baseURL/?lat1=${l1.latitude}&lon1=${l1.longitude}&lat2=${l2.latitude}&lon2=${l2.longitude}";
    return "$baseURL/?format=json";
  }


  Future<List<LatLng>?> getRouteCoordinates(LatLng l1, LatLng l2) async {
    var response = await http.get(Uri.parse(baseURL));
    print(response.body);
    if (response.statusCode == 200) {
      final temp = ServiceModel.fromJson(jsonDecode(response.body));
      return temp.geometry.coordinates;
    } else {
      // throw Exception('Failed to load route');
      return null;
    }
  }
}
