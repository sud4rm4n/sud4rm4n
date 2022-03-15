import 'package:apps2/provider/locationProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapTrackingPage extends StatefulWidget {
  const MapTrackingPage({Key? key}) : super(key: key);

  @override
  State<MapTrackingPage> createState() => _MapTrackingPageState();
}

class _MapTrackingPageState extends State<MapTrackingPage> {
  late Set<Marker> _markers = {};
  LatLng _kMapCenter = LatLng(-6.1333155, 106.8789277);
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).initialization();
    _markers.add(
      Marker(
        markerId: MarkerId("3.595196, 98.672226"),
        position: _kMapCenter,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Tracking"),
        backgroundColor: Colors.blue,
      ),
      body: googleMapUI()
    );
  }

  Widget googleMapUI () {
    return Consumer<LocationProvider>(
      builder: (consumerContext, model, child) {
        if(model.locationPosition != null) {
          return Column(
            children: [
              Expanded(child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: model.locationPosition,
                    zoom: 18
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {},
              )
              )
            ],
          );
        }
        return Container(
          child: Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}

