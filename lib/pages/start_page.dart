import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        //fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg3x.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //+++
          Center(
            child: animateLogo(),
          ),
        ],
      ),
    );
  }

  animateLogo() {
    // Timer(
    //   Duration(milliseconds: 0),
    //   () {},
    // );

    return PlayAnimation<double>(
      tween: (50.0).tweenTo(180.0),
      duration: 800.milliseconds,
      builder: (context, child, value) {
        return Container(
          width:
              value, // <-- apply animated value obtained from builder function parameter
          height:
              value, // <-- apply animated value obtained from builder function parameter
          // color: Colors.green,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/logo-jari1.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
