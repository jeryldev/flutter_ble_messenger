import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AnimationProps { opacity, translateY }

class Fade extends StatelessWidget {
  final double delay;
  final Widget child;

  Fade(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationProps>()
      ..add(AnimationProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(AnimationProps.translateY, (-130.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AnimationProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(AnimationProps.translateY)),
            child: child),
      ),
    );
  }
}
