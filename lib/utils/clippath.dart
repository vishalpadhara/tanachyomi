import 'package:flutter/material.dart';

class ClipPathValue extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {

    Path _path = Path();


    _path.lineTo(0, size.height - 25);
    //_path.lineTo(size.width - , size.height);

    _path.conicTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - size.height / 2.5, 15);

    //_path.lineTo(size.width, size.height - 50);
    _path.lineTo(size.width, 0);

    _path.close();

    return _path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}