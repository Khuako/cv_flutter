import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorModel extends ChangeNotifier {
  String example = '';
  String answer = '';
  void remove() {
    if (example != '') {
      example = example.substring(0, example.length - 1);
      notifyListeners();
    }
  }

  void clear() {
    example = '';
    answer = '';
    notifyListeners();
  }

  void addSymbol(String symbol) {
    example += symbol;
    notifyListeners();
  }

  void equals(BuildContext context) {
    try {
      Parser p = Parser();
      String expression = example;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      Expression exp = p.parse(expression);
      answer =
          exp.evaluate(EvaluationType.REAL, ContextModel()).toStringAsFixed(2);
      notifyListeners();
    } catch (e) {
      const snackBar = SnackBar(
        content: Center(child: Text('Введено некорректное выражение')),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class CalculatorModelProvider extends InheritedNotifier {
  final CalculatorModel model;
  const CalculatorModelProvider({
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static CalculatorModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<CalculatorModelProvider>();
  }

  static CalculatorModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<CalculatorModelProvider>()
        ?.widget;
    return widget is CalculatorModelProvider ? widget : null;
  }
}
