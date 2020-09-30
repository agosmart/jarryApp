import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AniProps { width, height, opacity, translateY }

class CustomFadeScaleAnimation extends StatelessWidget {
  // const CustomFadeScal({Key key}) : super(key: key);

  final int delay;
  final int duration;
  final Widget childContent;
  final double widthContent;
  final double heightContent;

  CustomFadeScaleAnimation(
      {this.delay,
      this.duration,
      this.widthContent,
      this.heightContent,
      @required this.childContent});

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.width, Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500), Curves.easeOut)
    ..add(AniProps.height, Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500), Curves.easeOut)
    ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500), Curves.easeOut);

  @override
  Widget build(BuildContext context) {
    print('Anim::: FADE + SCALE');
    //print('delay:::$delay + $widthContent');
    double w =
        widthContent == null ? MediaQuery.of(context).size.width : widthContent;
    double h = heightContent == null
        ? MediaQuery.of(context).size.height
        : heightContent;

    //print('delay:::$delay + $w');

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: Duration(seconds: duration),
      tween: _tween, // Pass in tween
      child: childContent,
      // Pass in total duration obtained from MultiTween
      builder: (context, childContent, animation) {
        return Container(
          width: animation.get(AniProps.width) * w,
          height: animation.get(AniProps.height) * h,
          //color: Colors.yellow,
          child: Opacity(
            opacity: animation.get(AniProps.opacity),
            child: childContent,
          ),
        );
      },
    );
  }
}
