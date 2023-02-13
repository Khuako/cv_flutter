import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/auth/auth_widget.dart';

abstract class AppButtonStyle {
  static final ButtonStyle linkButton = ButtonStyle(
    foregroundColor: MaterialStateProperty.all(colorY),
    textStyle: MaterialStateProperty.all(
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  );
}
