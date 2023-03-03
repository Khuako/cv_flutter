import 'dart:math';

import 'package:animated_switch/provider_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class SwitchAnimation extends StatefulWidget {
  const SwitchAnimation({super.key});

  @override
  State<SwitchAnimation> createState() => _SwitchAnimationState();
}

class _SwitchAnimationState extends State<SwitchAnimation> {
  @override
  Widget build(BuildContext context) {
    ProviderSwitch _state = Provider.of<ProviderSwitch>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework Provider',
          style: TextStyle(color: _state.appbarTextValue),
        ),
        centerTitle: true,
        backgroundColor: _state.appbarBackValue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 1),
              width: 200,
              height: 200,
              color: _state.animatedContainerValue,
            ),
            SizedBox(
              height: 20,
            ),
            Switch(
              value: _state.lightValue,
              onChanged: _state.changeColors,
            ),
          ],
        ),
      ),
    );
  }
}
