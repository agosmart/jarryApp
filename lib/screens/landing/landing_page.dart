import 'package:flutter/material.dart';
import 'package:jariapp/screens/home/home.page.dart';
import 'package:jariapp/themes/colors.dart';

import 'package:jariapp/widgets/animations/custom.fade.scale.animation.dart';
import 'package:jariapp/widgets/animations/custom.fade.translate.animation.dart';
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
        AnimationController(vsync: this, duration: Duration(milliseconds: 800))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: HomePage(),
                  settings: RouteSettings(name: "/home"),
                ),
              );
            }
          });

    scaleAnimation =
        Tween<double>(begin: 1.0, end: 20.0).animate(scaleController);

    /*

    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

  

 
    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });


    rippleController.forward();
  */

    //++++++++++++++++++++++++++++

    /*
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation = Tween<double>(begin: 1.0, end: 32.0).animate(
        _scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: HomePage()));
        }
      });
      */
  }

  @override
  Widget build(BuildContext context) {
    //+++++++++++++++++++++++++++++++++++++++++

    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    //++++++++++++++++++++++++++++++++++++++++++++
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
            /*
            Positioned(
              top: -15.0,
              left: -5.0,
              child: animateLeafsMulti(),
            ),
            */

            /*
            //++++
            Positioned(
              bottom: 10.0,
              right: 20.0,
              child: animateLeafs(),
            ),
            */

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

/*
  Widget animateLeafsMulti() {
    return CustomFadeScaleAnimation(
      delay: 2000, //millisecondes
      //  duration: 3000, //millisecondes

      duration: 1500, //millisecondes

      childContent: Container(
        // color: Colors.green,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/leafs-multi.webp',
            ),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget animateLeafs() {
    return CustomFadeScaleAnimation(
      delay: 3000, //millisecondes
      duration: 2000, //millisecondes
      widthContent: 216.0,
      heightContent: 155.0,
      childContent: Container(
        // color: Colors.green,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/leafs.webp',
            ),
            fit: BoxFit.contain,
          ),
          // color: Colors.green,
        ),
      ),
    );
  }
*/
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
                            : Container(
                                height: 12.0,
                                width: 6.0,
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'assets/images/logo-jari1.webp',
                                  //fit: BoxFit.scaleDown,
                                  height: 6.0,
                                  width: 6.0,
                                ),
                              ),
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
/*
  Widget buttonStartRippleAnimation() {
    //CustomFadeTranslateAnimation()
    return AnimatedBuilder(
      animation: rippleAnimation,
      builder: (context, child) => Container(
        width: rippleAnimation.value,
        height: rippleAnimation.value,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.blue.withOpacity(.4)),
          child: Stack(
            // alignment: Alignment.center,
            children: [
              InkWell(
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
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.0,
                              1.0), // 10% of the width, so there are ten blinds.
                          colors: [
                            const Color(0xFF002775),
                            const Color(0xFF008FD7)
                          ], // whitish to gray
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  */
/*
  Widget buttonStart() {
    //++++

    return CustomFadeScaleAnimation(
      delay: 4,
      duration: 2,
      // widthContent: 216.0,
      // heightContent: 155.0,
      childContent: AnimatedBuilder(
        animation: _scaleController,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Center(
            child: AnimatedBuilder(
              animation: _widthController,
              builder: (context, child) => Container(
                width: _widthAnimation.value,
                height: 80,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue.withOpacity(.4)),
                child: InkWell(
                  onTap: () {
                    _scaleController.forward();
                  },
                  child: Stack(
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: _positionController,
                        builder: (context, child) => Positioned(
                          left: _positionAnimation.value,
                          child: AnimatedBuilder(
                            animation: _scale2Controller,
                            builder: (context, child) => Transform.scale(
                                scale: _scale2Animation.value,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue),
                                  child: hideIcon == false
                                      ? Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      : Container(),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    //+++
  }*/

  //++++++++++  END +++++++++
}
