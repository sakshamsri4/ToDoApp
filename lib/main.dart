import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'To Do List',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('To do List'),
        ),
      ),
    );
  }
}
