import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _toDoItems = [];

  Widget _buildToDoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _toDoItems.length) {
          return _buildToDoItem(_toDoItems[index]);
        }
      },
    );
  }

  void _addToDoItems() {
    setState(() {
      int index = _toDoItems.length;
      _toDoItems.add('Item' + index.toString());
    });
  }

  Widget _buildToDoItem(String toDoText) {
    return new ListTile(
      title: new Text(toDoText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text('To do List'),
      ),
      body: _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addToDoItems,
        tooltip: 'Add Task',
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
