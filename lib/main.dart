import 'package:flutter/material.dart';
import 'package:jariapp/providers/category.dart';
import 'package:jariapp/providers/location.api.dart';
import 'package:jariapp/providers/map.dart';
import 'package:jariapp/providers/products.dart';
import 'package:jariapp/root/routes.dart';
import 'package:jariapp/screens/landing/landing_page.dart';

import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
//import 'package:jariapp/old/start_page_ripple.dart';

void main() {
//----- Smooth Scrolling +++++++++
  // GestureBinding.instance.resamplingEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//++++++++++++et Change Status Bar Background Color ++++++++++
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF172744),
    ));
//+++++++++++++++++++++++++++++++
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
          lazy: false,
        ),

        ChangeNotifierProvider<MapProvider>(
          create: (_) => MapProvider(),
          lazy: false,
        ),

        // ProxyProvider<LocationProvider, MapProvider>(
        //   update: (_, locality, __) =>
        //       MapProvider(locality.getcurrentLocalityID),
        // ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Jarry App',
          onGenerateRoute: Routes.materialRoutes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Bariol',
          ),
          //home: StartPageRipple(),
          home: LandingPage(),
        );
      },
      //+++++++++++++++++++++++++++++++
    );
  }
}
