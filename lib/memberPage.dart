import 'package:apps2/main.dart';
import 'package:apps2/mapTrackingPage.dart';
import 'package:apps2/provider/locationProvider.dart';
import 'package:apps2/trackLocationPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main () {
  runApp(MemberPage());
}
class MemberPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LocationProvider(),
      child: MapTrackingPage(),)
    ],
      child: MaterialApp(
        title: 'Map Tracking',
        home: MapTrackingPage(),
      ),
    );

  }
}
