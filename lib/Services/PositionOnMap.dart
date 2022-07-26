import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class PositionOnMap {

  static Future<LatLng> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    LatLng latLng = LatLng(position.latitude,
        position.longitude);
    return latLng;
  }

  static Future<LatLng> getCoordinates({required String address}) async{
    List<Location> locations = await locationFromAddress(address);
    LatLng latLng = LatLng(locations.first.latitude, locations.first.longitude);
    return latLng;
  }
}