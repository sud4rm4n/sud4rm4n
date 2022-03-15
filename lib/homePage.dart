import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

class HomePage extends StatelessWidget {
  HomePage({required this.username});
  final String username;

  List<String> recipents = ["085899064793"];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome $username',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome $username'),
          centerTitle: true,
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(4),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            InkWell(
            onTap: ()
             {
               Navigator.pushReplacementNamed(context, '/MemberPage');
             },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Icon(
                      Icons.map,size:50,color: Colors.white,
                    ),
                    Text("Track",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
                  ],
                ),

              ),
            ),
            InkWell(
              onTap: ()
              {
                Navigator.pushReplacementNamed(context, '/TrackLocationPage');
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Icon(
                      Icons.alarm,size:50,color: Colors.white,
                    ),
                    Text("Alarm",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
                  ],
                ),

              ),
            ),
            InkWell(
              onTap: ()
              {
                _sendSMS("This is a test message!", recipents);
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: [
                    Icon(
                      Icons.lock,size:50,color: Colors.white,
                    ),
                    Text("Lock",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),)
                  ],
                ),

              ),
            ),

          ],
        ),
      ),
    );
  }
}

void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}
//sendSMS(message: message, recipients: recipents)