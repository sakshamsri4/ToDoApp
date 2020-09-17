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
          return _buildToDoItem(_toDoItems[index], index);
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

  Widget _buildToDoItem(String toDoText, int index) {
    return new ListTile(
      title: new Text(toDoText),
      subtitle: new Text(toDoText),
      onTap: () {
        _promptRemoveToDoItem(index);
      },
    );
  }

  void _pushAddToDoItems() {
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
                    onTap: () {},
                    child: Icon(Icons.delete_forever),
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
                new TextField(
                  autofocus: true,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w900),
                  //onChanged
                  onSubmitted: (val) {
                    _addToDoItems(val);
                  },
                  decoration: new InputDecoration(
                      hintText: 'Enter Title...',
                      contentPadding: const EdgeInsets.all(16.0)),
                ),
                new TextField(
                  autofocus: true,
                  maxLines: 15,
                  style: TextStyle(
                      fontSize: 18.0,
                      height: 1,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600),
                  onSubmitted: (val) {},
                  decoration: new InputDecoration(
                      hintText: 'Enter Description',
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
    setState(() {
      _toDoItems.removeAt(index);
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
        onPressed: _pushAddToDoItems,
        tooltip: 'Add Task',
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
