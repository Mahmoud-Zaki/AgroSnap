import 'package:agrosnap/Componants/RoundedButton.dart';
import 'package:agrosnap/Componants/SearchBar.dart';
import 'package:agrosnap/Provider/MapNotifier.dart';
import 'package:agrosnap/Provider/StorePageNotifier.dart';
import 'package:agrosnap/Services/PositionOnMap.dart';
import 'package:agrosnap/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final LatLng initialLatLng;
  final bool user, initialMarker,arabic,dark;
  MapView({required this.initialLatLng,required this.user,required this.initialMarker,
    required this.arabic,required this.dark});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late LatLng latLng;
  late GoogleMapController mapController;

  void _cameraControl({required LatLng newLatLng}) {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: newLatLng,
          zoom: 18.0,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    latLng = widget.initialLatLng;
    Provider.of<MapNotifier>(context,listen: false)
        .clearMarkers();
    if(widget.user||widget.initialMarker)
      Provider.of<MapNotifier>(context,listen: false)
          .setInitialMarker(latLng: widget.initialLatLng);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: (widget.arabic)?TextDirection.rtl:TextDirection.ltr,
          child: Stack(
            children: [
              Consumer<MapNotifier>(
                builder:  (context, mapNotifier, child) =>
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target: widget.initialLatLng,zoom: 18.0),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    markers: Set<Marker>.from(mapNotifier.markers),
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    onCameraMove: (CameraPosition newPosition) {
                      latLng = newPosition.target;
                    },
                  ),
              ),
              Positioned(
                top: Constants.getScreenHeight(context)*0.02,
                child: SearchBar(
                  readOnly: false,txt: "ابحث عن مكان",map: true,dark: widget.dark,
                  function: (String input) async{
                    if(input.trim()!=""){
                      LatLng location = await PositionOnMap.getCoordinates(address: input);
                      _cameraControl(newLatLng: location);
                    }
                  }
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                top: 0.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.location_on,
                    color: Constants.primaryColor,
                    size: 50.0,
                  ),
                ),
              ),
              Positioned(
                bottom: Constants.getScreenHeight(context)*0.01,
                left: Constants.getScreenWidth(context)*0.01,
                child: RoundedButton(
                  color: Constants.secondaryColor,txt: (widget.user)?"إضافة علامة":"حفظ",
                  horizontalPadding: (widget.user)?0.05:0.1,
                  function: () {
                    if(widget.user)
                      Provider.of<MapNotifier>(context,listen: false).setMarker(latLng: latLng);
                    else {
                      Provider.of<StorePageNotifier>(context,listen: false).setLatLng(latLng: latLng,arabic: widget.arabic,dark: widget.dark);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: (widget.dark)?Constants.darkOrange:Constants.orange,
          child: Icon(Icons.my_location),
          onPressed: () async{
            LatLng location = await PositionOnMap.getCurrentPosition();
            _cameraControl(newLatLng: location);
          },
        ),
      ),
    );
  }
}