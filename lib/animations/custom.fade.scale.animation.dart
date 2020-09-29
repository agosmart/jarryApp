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
    print('delay:::$delay');
    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      tween: _tween, // Pass in tween
      duration: Duration(seconds: duration),
      child: childContent,
      // Pass in total duration obtained from MultiTween
      builder: (context, childContent, value) {
        return Container(
          width: value.get(AniProps.width) *
              widthContent, // Get animated width value
          height: value.get(AniProps.height) *
              heightContent, // Get animated height value
          //color: Colors.yellow,
          child: Opacity(
            opacity: value.get(AniProps.opacity),
            child: childContent,
          ),
        );
      },
    );
  }
}
