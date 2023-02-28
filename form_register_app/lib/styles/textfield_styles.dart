import 'package:flutter/material.dart';

abstract class TextFieldStyles {
  static const enabled = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.black, width: 2),
  );
  static const focused = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    borderSide: BorderSide(color: Colors.blue, width: 2),
  );
}
