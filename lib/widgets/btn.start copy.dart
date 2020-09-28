import 'package:flutter/material.dart';

class ButtonStart extends StatefulWidget {
  ButtonStart({Key key}) : super(key: key);

  @override
  _ButtonStartState createState() => _ButtonStartState();
}

class _ButtonStartState extends State<ButtonStart>
    with SingleTickerProviderStateMixin {
  //----
  AnimationController _animationController;
  bool _canTap;
  //---
  @override
  void initState() {
    super.initState();
    //++++
    _canTap = true;
    //++++
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    //++++
    _animationController.addListener(() {
      this.setState(() {});

      _animationController.isCompleted
          ? setState(() {
              _canTap = true;
            })
          : setState(() {
              _canTap = false;
            });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                _animationController.isAnimating
                    ? _animationController.value.toStringAsFixed(3)
                    : "Tap me!",
                style: new TextStyle(fontSize: 24.0, color: Colors.white),
              ),
            ),
          ),
        ),
        onTap: _canTap
            ? () {
                print('canTap');
                _animationController.forward(from: 0.0);
              }
            : () {
                print('can not Tap');
              });
  }
}
