import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;

void main(List<String> arguments) {
  String s = "a ";
  if (!s.contains(" ")) {
    print(s.length);
  }
  List<String> v = s.split(" ");
  print(v);
  int ans = 0;
  int i = v.length - 1;
  while (i >= 0) {
    if (v[i].length != 0) {
      ans = v[i].length;
      print(ans);
      break;
    }
    i--;
  }
}
