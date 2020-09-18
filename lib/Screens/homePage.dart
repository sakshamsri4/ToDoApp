import 'dart:async';
import 'dart:convert';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _toDoItems = [];
  List<Todo> list = new List<Todo>();
  SharedPreferences sharedPreferences;
  List<String> _toDoDescr = [];
  String _item = '';
  String _desc = '';

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      list = listString.map((item) => Todo.fromMap(json.decode(item))).toList();
      setState(() {});
    }
  }

  Future<void> saveData() async {
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
  }

  Widget emptyList() {
    return Center(
      child: Text('No Items'),
    );
  }

  Widget _buildToDoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < list.length) {
          int l = list.length;
          return _buildToDoItem(list[l - index - 1].title, index,
              list[l - index - 1].description);
          //list[l - index - 1],
          //index);
        }
      },
    );
  }

  void _addToDoItems(String task) {
    if (task.length > 0) {
      setState(() {
        _toDoItems.add(task);
      });
    }
  }

  void _addToDoDesc(String task) {
    if (task.length > 0) {
      setState(() {
        _toDoDescr.add(task);
      });
    }
  }

  Widget _buildToDoItem(
    String task,
    int index,
    String desc,
  ) {
    return new ListTile(
      title: new Text(task),
      //subtitle: new Text(toDoDesc),
      onTap: () {
        _pushViewToDoItems(task, desc, index);
        //  _promptRemoveToDoItem(index);
      },
    );
  }

  void _pushViewToDoItems(String task, String taskDesc, int index) {
    //  _removeToDoItem(index);
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text('Edit Task '),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (list.length > 0) {
                          _removeToDoItem(
                              index, Todo(title: task, description: taskDesc));
                        }
                        Navigator.pop(context);
                      });
                    },
                    child: Icon(Icons.delete_forever),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _pushAddToDoItems(task, taskDesc);
                        _removeToDoItem(
                            index, Todo(title: task, description: taskDesc));
                        //Navigator.pop(context);
                      });
                    },
                    child: Icon(Icons.edit),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.check_circle),
                  ),
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    task,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Text(
                    taskDesc,
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.share),
              onPressed: () async => await _shareText(task, taskDesc),
            ),
          );
        },
      ),
    );
  }

  Future<void> _shareText(String task, String taskDesc) async {
    try {
      Share.text('my text title', '*' + '$task' + '*' + '\n' + '$taskDesc',
          'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  void _pushAddToDoItems(String task, String taskDesc) {
    _item = task;
    _desc = taskDesc;

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.redAccent,
              title: Text('Add new Task '),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      list.add(Todo(title: _item, description: _desc));
                      print(list[0].title);
                      print(list.length);
                      _addToDoItems(_item);
                      _addToDoDesc(_desc);
                      saveData();

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          ModalRoute.withName("/Home"));
                    },
                    child: Icon(Icons.check_circle),
                  ),
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                new TextField(
                  autofocus: true,
                  maxLines: 1,
                  controller: TextEditingController()..text = '$task',
                  textCapitalization: TextCapitalization.characters,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                  //onChanged
                  /*onSubmitted: (val) {
                    _addToDoItems(val);
                  },*/
                  onChanged: (val) {
                    _item = val;
                  },

                  decoration: new InputDecoration(
                      hintText: 'Enter title...',
                      contentPadding: const EdgeInsets.all(16.0)),
                ),
                new TextField(
                  autofocus: true,
                  maxLines: 10,
                  controller: TextEditingController()..text = '$taskDesc',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                  onChanged: (val) {
                    _desc = val;
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter Description...',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16.0)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _removeToDoItem(int index, Todo item) {
    index = list.length - index - 1;

    setState(() {
      print(list.length);
      print(list[index].title);
      list.removeAt(index);
      saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: new Text('To do List'),
      ),
      body: list.isEmpty ? emptyList() : _buildToDoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pushAddToDoItems('', '');
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
