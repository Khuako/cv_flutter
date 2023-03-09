class Cell {
  int? id;
  String? name;
  String? text;
  Cell(this.id, this.name, this.text);
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['text'] = text;
    return map;
  }

  Cell.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    text = map['text'];
  }
}
