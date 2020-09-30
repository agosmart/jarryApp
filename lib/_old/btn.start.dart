import 'package:flutter/material.dart';
import 'package:jariapp/screens/home/home.page.dart';

import 'package:page_transition/page_transition.dart';

class ButtonStart extends StatefulWidget {
  ButtonStart({Key key}) : super(key: key);

  @override
  _ButtonStartState createState() => _ButtonStartState();
}

class _ButtonStartState extends State<ButtonStart>
    with TickerProviderStateMixin {
  //+++++++++++

  AnimationController rippleController;
  AnimationController scaleController;
  AnimationController fadeController;

  Animation<Offset> rippleAnimation;
  Animation<double> scaleAnimation;
  Animation<double> fadeAnimation;

  //++++++++
  bool _canTap;
  //---
  @override
  void initState() {
    super.initState();

    //------------------------- Controllers ------------------------------
    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: HomePage(),
                  ));
            }
          });
    //++++
    fadeController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    //------------------------- Animations ------------------------------

    //++++
    /*rippleAnimation =
        Tween<double>(begin: 20.0, end: 50.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });
    */
    //++++
    rippleAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1.0))
        .animate(CurvedAnimation(
            parent: rippleController, curve: Curves.decelerate));

    //++++
    scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(scaleController);
    //++++
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: fadeController, curve: Curves.decelerate));

    //------------------------- SATART ANIM ------------------------------

    rippleController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    //_animationController.dispose();
    scaleController.dispose();
    rippleController.dispose();
    fadeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          //color: Colors.blue,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.0, 1.0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xFF002775),
              const Color(0xFF008FD7)
            ], // whitish to gray
          ),
        ),
      ),
    );

    /*
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
        animation: rippleAnimation,
        builder: (context, child) => Container(
          width: rippleAnimation.value,
          height: rippleAnimation.value,
          child: Container(
            width: rippleAnimation.value,
            height: rippleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(.4),
              ),
              child: InkWell(
                onTap: () {
                  scaleController.forward();
                },
                child: AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    */
    /*return GestureDetector(
      child: Center(
        child: Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
              //gradient: LinearGradient(colors: [ 0xFF002775, 0xFF008FD7 ]),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.0, 1.0), // 10% of the width, so there are ten blinds.
                colors: [
                  const Color(0xFF002775),
                  const Color(0xFF008FD7)
                ], // whitish to gray
              ),
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 6.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 5.0))
              ]),
          child: Center(
            child: Text(
              "Tap me!",
              style: new TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
        ),
      ),
      onTap: () {},
    );*/
  }
}
