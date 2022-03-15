import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
class MemberPage extends StatelessWidget {
  MemberPage({required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Map Tracking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var fld_gpslat;
  var fld_gpslong;
  var _mapPoint;
  var gps;
  bool loading = false;
  Future <void> getGPS() async {
    setState(() {
      loading = true;
    });
    http.Response res = await http.get(Uri.parse(
        'http://172.16.1.71/gpstrack/getLocationUpdate.php'));
    setState(() {
      loading = false;
    });
    var jsonData = jsonDecode(res.body);
     print ("OKEE");
     print(jsonData);
    setState(() {
      gps = jsonData;
    });
    print(gps);

  }



  Future<List> _getGPSData() async {
    final response =
    await http.post(Uri.parse("http://172.16.1.71/gpstrack/getLocationUpdate.php"), body: {
      "username": "koala",
      "password": "semangat",
    });
    print("Pedangsing");
    var gpsData = json.decode(response.body);
    print(gpsData);
    setState(() {
      fld_gpslat = gpsData[0]['fld_gpslat'];
      fld_gpslong = gpsData[0]['fld_gpslong'];
    });
    print(fld_gpslat);
    final LatLng _mapPoint = LatLng(fld_gpslat, fld_gpslong);
    final Set<Marker> _markersMap = {};
    final CameraPosition _initialPosition =
    CameraPosition(target: _mapPoint,zoom: 14.0,tilt: 0,bearing: 0);
    return  gpsData;
  }


  static final LatLng _kMapCenter = LatLng(-6.1333155, 106.8789277);
  final Set<Marker> _markers = {};
  static final CameraPosition _kInitialPosition =
  CameraPosition(target: _kMapCenter,zoom: 14.0,tilt: 0,bearing: 0);


  @override
  void initState() {
    getGPS();
    print ("TEST");
    print(gps);
    _markers.add(
      Marker(
        markerId: MarkerId("3.595196, 98.672226"),
        position: _kMapCenter,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        markers: _markers,
      ),
    );
  }

}




