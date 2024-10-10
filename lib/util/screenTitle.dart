import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String? text;
  final Color? color;

  const ScreenTitle({
    required Key key,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: Text(
        text!,
        style:
            TextStyle(fontSize: 30, color: color, fontWeight: FontWeight.bold),
      ),
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(microseconds: 500),
      builder: (BuildContext context, double _value, Widget? child) {
        return Opacity(
          opacity: _value,
          child: child,
        );
      },
    );
  }
}
