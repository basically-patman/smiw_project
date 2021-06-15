import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smiw_project/pong.dart';



class Option {
  Icon icon;
  String title;
  String subtitle;

  Option({this.icon, this.title, this.subtitle});
}

final options = [
  Option(
    icon: Icon(Icons.sports_baseball, size: 40.0),
    title: 'Singleplayer',
    subtitle: 'Play alone.',
  ),
  Option(
    icon: Icon(Icons.people_alt_sharp, size: 40.0),
    title: 'Multiplayer',
    subtitle: 'Play with friend.',
  ),
];