import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:jarryApp/providers/category.dart';
import 'package:jarryApp/providers/location.api.dart';
import 'package:jarryApp/providers/map.dart';
import 'package:jarryApp/providers/order.dart';
import 'package:jarryApp/providers/products.dart';
import 'package:jarryApp/responsive/size_config.dart';
import 'package:jarryApp/root/routes.dart';
import 'package:jarryApp/screens/landing/landing_page.dart';

import 'package:provider/provider.dart';

//import 'package:device_preview/device_preview.dart';

/*
void main() {
//----- Smooth Scrolling +++++++++
  // GestureBinding.instance.resamplingEnabled = true;
  runApp(MyApp());
}
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

/*
void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );
*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//++++++++++++et Change Status Bar Background Color ++++++++++
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF94A4C0).withAlpha(75),
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
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(),
          lazy: false,
        ),

        // ProxyProvider<LocationProvider, MapProvider>(
        //   update: (_, locality, __) =>
        //       MapProvider(locality.getcurrentLocalityID),
        // ),
      ],
      builder: (context, child) {
        //.........................
        return LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            //..........
            SizeConfig().init(constraints, orientation);
            //++++++++++++++++++++++++++
            return MaterialApp(
              //++++++++++++++++++++
              // locale: DevicePreview.locale(context), // Add the locale here
              // builder: DevicePreview.appBuilder, // Add the builder here

              //++++++++++++++++++++
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

            //++++++++++++++++++++++++++
          });
        });

        //.........................
      },
      //+++++++++++++++++++++++++++++++
    );
  }
}
