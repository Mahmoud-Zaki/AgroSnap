import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNotifier extends ChangeNotifier {
  Set<Marker> markers = {};

  void setInitialMarker({required LatLng latLng}){
    if(markers.length == 2)
      markers.remove(markers.last);

    markers.add(Marker(
      markerId: MarkerId('$latLng'),
      position: latLng,
      icon: BitmapDescriptor.defaultMarker,
    ));
  }

  void setMarker({required LatLng latLng}) {
    if(markers.length == 2)
      markers.remove(markers.last);

    markers.add(Marker(
      markerId: MarkerId('$latLng'),
      position: latLng,
      icon: BitmapDescriptor.defaultMarker,
    ));
    notifyListeners();
  }

  void clearMarkers(){
    markers.clear();
  }
}