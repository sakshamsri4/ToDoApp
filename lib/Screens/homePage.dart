import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _toDoItems = [];
  List<String> _toDoDescr = [];
  String _item = '';
  String _desc = '';

  Widget _buildToDoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _toDoItems.length) {
          int l = _toDoItems.length;
          return _buildToDoItem(
              _toDoItems[l - index - 1], index, _toDoDescr[l - index - 1]);
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

  Widget _buildToDoItem(String toDoText, int index, String toDoDesc) {
    return new ListTile(
      title: new Text(toDoText),
      //subtitle: new Text(toDoDesc),
      onTap: () {
        _pushViewToDoItems(toDoText, toDoDesc, index);
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
                        if (_toDoItems.length > 0) {
                          _removeToDoItem(index);
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
                        _removeToDoItem(index);
                        //  Navigator.pop(context);
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
                      _addToDoItems(_item);
                      _addToDoDesc(_desc);
                      Navigator.pop(context);
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
                      hintText: '$task',
                      contentPadding: const EdgeInsets.all(16.0)),
                ),
                new TextField(
                  autofocus: true,
                  maxLines: 10,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                  onChanged: (val) {
                    _desc = val;
                  },
                  decoration: new InputDecoration(
                      hintText: '$taskDesc',
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

  void _removeToDoItem(int index) {
    index = _toDoItems.length - index - 1;

    setState(() {
      print(_toDoItems);
      print(_toDoDescr);
      print(index);
      print(_toDoItems.length);
      print(_toDoItems.isNotEmpty);
      _toDoItems.removeAt(index);
      _toDoDescr.removeAt(index);

      print(_toDoItems);
      print(_toDoDescr);
      print(_toDoItems.isNotEmpty);
      print(_toDoDescr.isNotEmpty);
      print(_toDoItems);
      print(index);
      print(_toDoItems.length);
    });
  }

  void _promptRemoveToDoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('Mark "${_toDoItems[index]}" as done?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: new Text('CANCEL'),
              ),
              new FlatButton(
                  child: new Text('MARK AS DONE'),
                  onPressed: () {
                    _removeToDoItem(index);
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
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
        onPressed: () {
          _pushAddToDoItems('Enter Title...', 'Enter Description...');
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
