import 'package:calulator_app/model.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            FirstFieldWidget(),
            SecondFieldWidget(),
            Expanded(
              child: Divider(),
            ),
            TableWidget(),
          ],
        ),
      ),
    );
  }
}

class FirstFieldWidget extends StatelessWidget {
  const FirstFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = CalculatorModelProvider.watch(context)?.model;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              model?.example == '' ? '0' : model!.example,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondFieldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = CalculatorModelProvider.watch(context)?.model;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              model!.answer == '' ? '0' : model.answer,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 42),
            ),
          ],
        ),
      ),
    );
  }
}

class TableWidget extends StatelessWidget {
  Widget singleButton(String buttonText, Color colorButton, double buttonHeight,
      BuildContext context) {
    final model = CalculatorModelProvider.watch(context)?.model;
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: ColoredBox(
        color: colorButton,
        child: TextButton(
          onPressed: () {
            if (buttonText == '7' ||
                buttonText == '8' ||
                buttonText == '9' ||
                buttonText == '4' ||
                buttonText == '5' ||
                buttonText == '6' ||
                buttonText == '1' ||
                buttonText == '2' ||
                buttonText == '3' ||
                buttonText == '.' ||
                buttonText == '0' ||
                buttonText == '00' ||
                buttonText == '×' ||
                buttonText == '+' ||
                buttonText == '-' ||
                buttonText == '÷') {
              try {
                model!.addSymbol(buttonText);
              } catch (e) {
                print('$e');
              }
            } else if (buttonText == 'C') {
              model!.clear();
            } else if (buttonText == '⌫') {
              model!.remove();
            } else if (buttonText == '=') {
              model!.equals(context);
            }
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Table(
            children: [
              TableRow(
                children: [
                  singleButton('C', Colors.red, 1, context),
                  singleButton('⌫', Colors.blue, 1, context),
                  singleButton('÷', Colors.blue, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('7', Colors.blueGrey, 1, context),
                  singleButton('8', Colors.blueGrey, 1, context),
                  singleButton('9', Colors.blueGrey, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('4', Colors.blueGrey, 1, context),
                  singleButton('5', Colors.blueGrey, 1, context),
                  singleButton('6', Colors.blueGrey, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('1', Colors.blueGrey, 1, context),
                  singleButton('2', Colors.blueGrey, 1, context),
                  singleButton('3', Colors.blueGrey, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('.', Colors.blueGrey, 1, context),
                  singleButton('0', Colors.blueGrey, 1, context),
                  singleButton('00', Colors.blueGrey, 1, context),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Table(
            children: [
              TableRow(
                children: [
                  singleButton('×', Colors.blue, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('+', Colors.blue, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('-', Colors.blue, 1, context),
                ],
              ),
              TableRow(
                children: [
                  singleButton('=', Colors.red, 2, context),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
