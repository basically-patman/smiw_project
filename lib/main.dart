
import 'package:flutter/material.dart';
import 'package:smiw_project/menuoptionsscreen.dart';
import 'pong.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pong v1.0.3',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Pong'),
            ),
            body: MenuOptionsScreen()
        ));
  }
}