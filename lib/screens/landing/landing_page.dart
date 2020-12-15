import 'package:flutter/material.dart';
import 'package:jarryApp/responsive/responsive_safe_area.dart';
import 'package:jarryApp/screens/home/home.page.dart';
import 'package:jarryApp/themes/colors.dart';

import 'package:jarryApp/widgets/animations/custom.fade.scale.animation.dart';
import 'package:jarryApp/widgets/animations/custom.fade.translate.animation.dart';
import 'package:page_transition/page_transition.dart';

enum AniProps { width, height, opacity }

class LandingPage extends StatefulWidget {
//------
  // bool _startAnim;
  // bool _startAnim2;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  double _width;
  double _height;

  // AnimationController _scaleController;
  // AnimationController _scale2Controller;
  // AnimationController _widthController;
  // AnimationController _positionController;

  // Animation<double> _scaleAnimation;
  // Animation<double> _scale2Animation;
  // Animation<double> _widthAnimation;
  // Animation<double> _positionAnimation;

  //AnimationController rippleController;
  AnimationController scaleController;

  // Animation<double> rippleAnimation;
  Animation<double> scaleAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();

    scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              //--------------------------------
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 400),
                  child: HomePage(),
                  settings: RouteSettings(name: "/homePage"),
                ),
              );
              //--------------------------------
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 20.0).animate(scaleController);
  }

  @override
  Widget build(BuildContext context) {
    //+++++++++++++++++++++++++++++++++++++++++

    // _width = MediaQuery.of(context).size.width;
    // _height = MediaQuery.of(context).size.height;

    //++++++++++++++++++++++++++++++++++++++++++++
    return ResponsiveSafeArea(
      //------
      builder: (context, size) {
        //++++++
        _width = size.width;
        _height = size.height;
        //++++++

        return Scaffold(
          body: Container(
            //color: Colors.red,
            child: Stack(
              //alignment: Alignment.topLeft,
              overflow: Overflow.visible,
              fit: StackFit.expand,
              children: <Widget>[
                //++++
                Container(
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/bg3x.webp',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //+++

                //+++
                Positioned(
                  top: 80.0,
                  width: _width,
                  child: Center(
                    child: animateLogo(),
                  ),
                ),
                //+++

                //+++++++++ BTN START +++++
                Positioned(
                  top: _height / 2,
                  width: _width,
                  // width: _width,
                  child: Center(
                      // child: buttonStartRippleAnimation(),
                      child: buttonStartHome()),
                ),
                //+++
              ],
            ),
          ),
        );
        //-----
      },
    );
  }

  Widget animateLogo() {
    return CustomFadeScaleAnimation(
      delay: 1000, //millisecondes
      duration: 2000, //millisecondes
      widthContent: 200.0,
      heightContent: 200.0,
      childContent: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/logo-jari1.webp',
              ),
              fit: BoxFit.contain,
            ),
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 30.0,
                  spreadRadius: 0.5,
                  offset: Offset(0, 0))
            ]),
      ),
    );
  }

  Widget buttonStartHome() {
    //CustomFadeTranslateAnimation()
    return CustomFadeTranslateAnimation(
      begin: 200.0,
      delay: 1200, //millisecondes
      duration: 1500, //millisecondes
      widthContent: 100.0,
      heightContent: 100.0,
      childContent: Container(
        child: Stack(
          // alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  hideIcon = true;
                });
                scaleController.forward();
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue.withOpacity(.4)),
                child: AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: Container(
                      child: Align(
                          alignment: Alignment.center,
                          child: !hideIcon
                              ? Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 30.0,
                                )
                              : Center()
                          // : Container(
                          //     height: 12.0,
                          //     width: 6.0,
                          //     alignment: Alignment.topCenter,
                          //     child: Image.asset(
                          //       'assets/images/logo-jari1.webp',
                          //       //fit: BoxFit.scaleDown,
                          //       height: 6.0,
                          //       width: 6.0,
                          //     ),
                          //   ),
                          ),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.lightblue,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.0,
                              1.0), // 10% of the width, so there are ten blinds.
                          colors: [
                            AppColors.darkblue,
                            AppColors.lightblue
                          ], // whitish to gray
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //++++++++++  END +++++++++
}
