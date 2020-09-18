class Todo {
  String title;
  String description;
  Todo({this.title, this.description});

  Todo.fromMap(Map map)
      : this.title = map['title'],
        this.description = map['description'];
  Map toMap() {
    return {
      'title': this.title,
      'description': this.description,
    };
  }
}
