class ToDo {
  String? id;
  String? description;
  String? creationDate;

  ToDo({this.id, this.description, this.creationDate});

  ToDo.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    description = json['description'];
    creationDate = json['creation_date'];
  }

  ToDo.fromTodo(ToDo todo) {
    description = todo.description;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['creation_date'] = this.creationDate;
    return data;
  }
}
