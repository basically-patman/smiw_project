import 'package:flutter/material.dart';



// ignore: must_be_immutable
class Ball extends StatelessWidget {
  int record;
  @override
  Widget build(BuildContext context) {
    final double diam = 50;
    return Container(
      width: diam,
      height: diam,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}