import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'example_widget_model.g.dart';

class ExampleWidgetModel {
  void doSome() async {
    var box = await Hive.openBox('testBox');
    box.put('ivan', User('IVAN', 54));
    print(box.values);
  }
}

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  User(this.name, this.age);
  @override
  String toString() => 'Name: $name, age: $age';
}

// class UserAdapter extends TypeAdapter<User> {
//   @override
//   final typeId = 0;
//   @override
//   User read(BinaryReader reader) {
//     // TODO: implement read
//     final name = reader.readString();
//     final age = reader.readInt();
//     return User(name, age);
//   }

//   @override
//   void write(BinaryWriter writer, User obj) {
//     // TODO: implement write
//     writer.writeString(obj.name);
//     writer.writeInt(obj.age);
//   }
// }
