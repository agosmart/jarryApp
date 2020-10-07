import 'package:flutter/material.dart';
import 'package:jariapp/screens/landing/landing_page.dart';
import 'package:jariapp/services/category.dart';
import 'package:jariapp/services/products.dart';
import 'package:provider/provider.dart';
//import 'package:jariapp/old/start_page_ripple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//+++++++++++++++++++++++++++++++
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
          lazy: false,
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
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
