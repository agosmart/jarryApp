import 'package:flutter/material.dart';
import 'package:jariapp/screens/landing/landing_page.dart';
//import 'package:jariapp/old/start_page_ripple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: StartPageRipple(),
      home: LandingPage(),
    );
  }
}
