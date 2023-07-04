import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xFFee7b64)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xFFee7b64)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Color(0xFFee7b64)),
  ),
);

void nextScreen(context, page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.linear);
        return ScaleTransition(
          scale: animation,
          alignment: Alignment.centerLeft,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    ),
  );
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    ),
  );
}

void showSnackBar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}
