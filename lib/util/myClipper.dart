import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 4, size.height / 2, size.width / 2, size.height - 100);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height - 50,
        size.width, size.height - 100);

    // path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0);

    path.close();

    return path;
    // throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}