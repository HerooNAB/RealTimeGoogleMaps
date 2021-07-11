import 'dart:async';

import 'package:client/Models/location_model.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:client/models/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {
  Location location = Location();
  LocationModel currentLocation;

  StreamController<LocationModel> locationController =
      StreamController<LocationModel>.broadcast();

  Stream<LocationModel> get getStreamData => locationController.stream;

  LocationService() {
    location.requestPermission().then((locationPermission) {
      if (locationPermission == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationValue) {
          locationController.add(LocationModel(
              latitude: locationValue.latitude,
              longitude: locationValue.longitude));
        });
      }
    });
  }

  static Future<String> upLoadLocation(latitude, longitude) async {
    final prefs = await SharedPreferences.getInstance();
    final keyToken = 'token';
    final token = prefs.get(keyToken) ?? 0;

    String apiUrl = '$URL_UPDATELOCATION';
    http.Response response = await http.post(apiUrl, body: {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      print("Result: ${response.body}");
    } else {
      print('that bai');
    }
    return response.body;
  }
}
