import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jariapp/widgets/btn.start.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class StartPage extends StatelessWidget {
//------
  // bool _startAnim;
  // bool _startAnim2;
  double _width;
  double _height;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        //color: Colors.red,
        child: Stack(
          //alignment: Alignment.topLeft,
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: _width,
              height: _height,
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
            Positioned.fill(
              child: animateLeafsMulti(),
            ),
            //++++
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: animateLeafs(),
            ), //+++
            Positioned(
              top: 150.0,
              width: _width,
              child: Center(
                child: animateLogo(),
              ),
            ),
            //+++++++++ BTN START +++++
            //ButtonStart()
            Positioned(
              top: (_height / 2) + 30.0,
              left: (_width / 2) - 60.0,
              child: ButtonStart(),
            ),

            //----------
          ],
        ),
      ),
    );
  }

  //++++++++++++ Widgets +++++++++++++++++++++++++++++++++++

  Widget animateLogo() {
    return PlayAnimation<double>(
      tween: (0.0).tweenTo(1.0),

      duration: 4.seconds,
      //delay: Duration(milliseconds: (300 * 2).round()),
      delay: 600.milliseconds,
      curve: Curves.easeOut,
      builder: (context, child, value) {
        return Opacity(
          opacity: value,
          //+++++++
          child: Container(
            width: 180.0 *
                value, // <-- apply animated value obtained from builder function parameter
            height: 180.0 *
                value, // <-- apply animated value obtained from builder function parameter
            // color: Colors.green,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/logo-jari1.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget animateLeafsMulti() {
    return PlayAnimation<double>(
      tween: Tween(
        begin: 0.0,
        end: 1.0,
      ),
      curve: Curves.easeInOut,
      duration: 3.seconds,
      // delay: Duration(milliseconds: (300 * 4).round()),
      delay: 2.5.seconds,

      builder: (context, child, value) {
        return Opacity(
          opacity: value,
          child: Container(
            // color: Colors.green,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/leafs-multi.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget animateLeafs() {
    return PlayAnimation<double>(
      tween: Tween(
        begin: 0.0,
        end: 1.0,
      ),
      duration: 2.seconds,
      delay: 1.5.seconds,
      curve: Curves.easeInOut,
      builder: (context, child, opacityValue) {
        return Opacity(
          opacity: opacityValue,
          child: Container(
            width: 216 *
                opacityValue, // <-- apply animated value obtained from builder function parameter
            height: 155.0 *
                opacityValue, // <-- apply animated value obtained from builder function parameter

            // color: Colors.green,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/leafs.png',
                ),
                fit: BoxFit.contain,
              ),
              // color: Colors.green,
            ),
          ),
        );
      },
    );
  }

  //+++++++++++++++++++ END +++++++++++++++++++++++++
}
