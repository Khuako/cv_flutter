import 'dart:math';

import 'package:flutter/material.dart';

class ProviderSwitch extends ChangeNotifier {
  Color _appbarText = Colors.white;
  Color _appbarBack = Colors.pink;
  Color _animatedCont = Colors.yellow;
  bool _light = true;
  bool get lightValue => _light;
  Color get appbarTextValue => _appbarText;
  Color get appbarBackValue => _appbarBack;
  Color get animatedContainerValue => _animatedCont;
  void changeColors(bool value) {
    _appbarText =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    _animatedCont =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    _appbarBack =
        Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    _light = value;
    notifyListeners();
  }
}
