import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  late BitmapDescriptor _pinLocationGPSIcon;
  BitmapDescriptor get pinLocationGPSIcon => _pinLocationGPSIcon;
  late Set<Marker> _markers = {};
  final MarkerId markerId = MarkerId("1");
  late Location _location;
  Location get location => _location;
  late LatLng _LocationPosition;
  LatLng get locationPosition => _LocationPosition;
  bool locationServiceActive = true;

  LocationProvider() {
    _location = new Location();
  }

  initialization() async {
    await getUserLocation();
   // await setCustomMapPin();
  }
  getUserLocation() async {
    bool _serviceEnabled;
    PermissionStatus _PermissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if(!_serviceEnabled) {
        return;
      }
    }
    _PermissionGranted = await location.hasPermission();
    if(_PermissionGranted == PermissionStatus.denied) {
      _PermissionGranted = await location.requestPermission();
      if(_PermissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      _LocationPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
      print(_LocationPosition);


      notifyListeners();
    });

    setCustomMapPin() async {
      _pinLocationGPSIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5), 'assets/icons/map-point.png');
    }
  }



}