import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';

enum AniProps { width, height, opacity, translateY }

class CustomFadeTranslateAnimation extends StatelessWidget {
  //+++++
  double begin;
  final int delay;
  final int duration;
  final Widget childContent;
  final double widthContent;
  final double heightContent;

  CustomFadeTranslateAnimation({
    this.begin,
    this.delay,
    this.duration,
    this.widthContent,
    this.heightContent,
    @required this.childContent,
  });

  @override
  Widget build(BuildContext context) {
    print('Anim::: FADE + TRANSLATION - Y');
    //+++++
    if (begin == null) begin = -130.0;
    // print('delay:::$delay + $widthContent');
    double w =
        widthContent == null ? MediaQuery.of(context).size.width : widthContent;
    double h = heightContent == null
        ? MediaQuery.of(context).size.height
        : heightContent;

    // print('delay:::$delay + $w');

    //++++

    final _tween = MultiTween<AniProps>()
      ..add(AniProps.translateY, Tween(begin: begin, end: 0.0),
          Duration(milliseconds: 500), Curves.decelerate)
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
        //++++++++++
        delay: Duration(milliseconds: delay),
        duration: Duration(milliseconds: duration),
        tween: _tween,
        child: childContent,
        //++++++++++++
        builder: (context, childContent, animation) {
          return Container(
            width: w,
            height: h,

            //++++++
            child: Opacity(
              opacity: animation.get(AniProps.opacity),
              child: Transform.translate(
                  offset: Offset(0, animation.get(AniProps.translateY)),
                  child: childContent),
            ),
          );
        });
  }
}
