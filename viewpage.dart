//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:reelhouse/main.dart';

class ViewPage extends StatelessWidget{  
 
  final List names = new List();
  final List filteredNames = new List();
  final String text = '';
  final TextEditingController _filter = new TextEditingController();

  var mainPage = ExamplePage();

  Widget _displayPage()
  {
    return new Container(
      child: Text("Temporary Text"),
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text('',
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ), 
    ),
    body: Container(
      child: _displayPage(),
    ),
    );
  }
}
