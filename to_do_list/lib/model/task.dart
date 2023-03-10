class Task {
  int? id;
  String? title;
  String? descr;
  String? date;
  Task(this.id, this.title, this.descr, this.date);
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['descr'] = descr;
    map['date'] = date;
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    descr = map['descr'];
    date = map['date'];
  }
}
