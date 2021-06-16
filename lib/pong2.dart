import 'dart:math';
import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';

enum Direction { up, down, left, right }

class Pong2 extends StatefulWidget {
  @override
  _Pong2State createState() => _Pong2State();
}

class _Pong2State extends State<Pong2> with SingleTickerProviderStateMixin {

  double width;
  double height;
  double posX;
  double posY;
  double batWidth;
  double batHeight;
  double batPosition = 0;
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  Animation<double> animation;
  AnimationController controller;
  double increment = 5;
  double randX = 1;
  double randY = 1;
  int score = 0;

  @override
  void initState() {
    super.initState();
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(hours: 999999),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        checkBorders();
        (hDir == Direction.right)
            ? posX += ((increment * randX).round())
            : posX -= ((increment * randX).round());
        (vDir == Direction.down)
            ? posY += ((increment * randY).round())
            : posY -= ((increment * randY).round());
      });

      checkBorders();
    });


    controller.forward();
  }

  Future<bool> _onWillPop() async {
    controller.stop();
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              controller.forward();
              Navigator.of(context).pop(false);

              },
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () {
              controller.stop();
              Navigator.of(context).pop(true);
          },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            height = constraints.maxHeight;
            width = constraints.maxWidth;
            batWidth = width / 5;
            batHeight = height / 20;
  
            return Stack(
              children: <Widget>[
                   Align(
                    alignment: Alignment.center,
                    child: Text(
                      score.toString(),
                      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 200, color: Colors.red.withOpacity(0.7)),
                      textAlign: TextAlign.center,
                    ),
                  ),

  
                Positioned(
                  child: Ball(),
                  top: posY,
                  left: posX,
                ),
                Positioned(
                    bottom: 0,
                    left: batPosition,
                    child: GestureDetector(
                        onHorizontalDragUpdate: (DragUpdateDetails update) =>
                            moveBat(update, context),
                        child: Bat(batWidth, batHeight))),
              ],
            );
          }
      ),
    );
  }

  void checkBorders() {
    double diameter = 50;
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diameter - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth + diameter)) {
        vDir = Direction.up;
        randY = randomNumber();
        setState(() {
          score++;
        });
      } else {
        controller.stop();
        showMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randX = randomNumber();
    }
  }

  void moveBat(DragUpdateDetails update, BuildContext context) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(100);
    return (50 + myNum) / 100;
  }

  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  controller.stop();
                  controller.dispose();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },)
            ],
          );
        }
    );
  }

}