import 'package:flutter/material.dart';

class Bat2 extends StatelessWidget {
  final double width;
  final double height;

  Bat2(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.red[900],
      ),
    );
  }
}