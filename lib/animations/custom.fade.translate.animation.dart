import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
// import 'package:supercharged/supercharged.dart';

enum AniProps2 { width, height, opacity, translateY }

class CustomFadeTranslateAnimation extends StatelessWidget {
  //+++++
  final double delay;
  final Widget child;

  CustomFadeTranslateAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final _tween = MultiTween<AniProps2>()
      ..add(AniProps2.translateY, Tween(begin: -130.0, end: 0.0),
          Duration(milliseconds: 500), Curves.decelerate)
      ..add(AniProps2.opacity, Tween(begin: 0.0, end: 1.0),
          Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps2>>(
      //++++++++++
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      //++++++++++++
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps2.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps2.translateY)),
            child: child),
      ),
    );
  }
}
