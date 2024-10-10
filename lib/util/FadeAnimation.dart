import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
// import 'package:simple_animations/simple_animations.dart';
// import 'package:flutter/animation.dart';

enum AnyProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnyProps>()
      ..add(AnyProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AnyProps.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AnyProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      tween: tween,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AnyProps.opacity),
        child: Transform.translate(
          offset: Offset(0, animation.get(AnyProps.translateY)),
          child: child,
        ),
      ),
    );

    // ignore: deprecated_member_use
    // final tween = MultiTrackTween([
    //   // ignore: deprecated_member_use
    //   Track("opacity")
    //       .add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
    //   // ignore: deprecated_member_use
    //   Track("translateY").add(
    //       Duration(milliseconds: 500), Tween(begin: -50.0, end: 1.0),
    //       curve: Curves.elasticOut)
    // ]);

    // ignore: deprecated_member_use
    // return ControlledAnimation(
    //   delay: Duration(milliseconds: (500 * delay).round()),
    //   duration: tween.duration,
    //   tween: tween,
    //   child: child,
    //   builderWithChild: (context, child, animation) => Opacity(
    //     opacity: animation["opacity"],
    //     child: Transform.translate(
    //         offset: Offset(0, animation["translateY"]), child: child),
    //   ),
    // );
  }
}
