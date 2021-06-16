import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smiw_project/pong.dart';
import 'package:smiw_project/pong2.dart';
import 'menuoption.dart';

class MenuOptionsScreen extends StatefulWidget {
  @override
  _MenuOptionsScreenState createState() => _MenuOptionsScreenState();

}


class _MenuOptionsScreenState extends State<MenuOptionsScreen> {
  int _selectedOption = 0;
  void _pushSaved(int t){
    SystemChrome.setEnabledSystemUIOverlays([]);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context){
          if (t == 2){
            return Scaffold(
                body: Pong(),
            );
          }
          else if (t == 1){
            return Scaffold(
              // ignore: missing_return
              body: Pong2(),
            );
          }
          else{
            return Scaffold(
                // ignore: missing_return
                body: null,
            );
          }
        }
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Menu Options'),
        // ignore: deprecated_member_use
      ),
      body: ListView.builder(
        itemCount: options.length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(height: 15.0);
          } else if (index == options.length + 1) {
            return SizedBox(height: 100.0);
          }
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10.0),
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: _selectedOption == index - 1
                  ? Border.all(color: Colors.black26)
                  : null,
            ),
            child: ListTile(
              leading: options[index - 1].icon,
              title: Text(
                options[index - 1].title,
                style: TextStyle(
                  color: _selectedOption == index - 1
                      ? Colors.black
                      : Colors.grey[600],
                ),
              ),
              subtitle: Text(
                options[index - 1].subtitle,
                style: TextStyle(
                  color:
                  _selectedOption == index - 1 ? Colors.black : Colors.grey,
                ),
              ),
              selected: _selectedOption == index - 1,
              onTap: () {
                _pushSaved(index);
                setState(() {
                  _selectedOption = index - 1;
                });
              }
              //onTap: ()  => _pushSaved(index),
            ),
          );},
      ),
    );
  }
}