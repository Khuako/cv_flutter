// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/screens/main_screen.dart';
import 'package:firebase_test/service/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await authService.registerUserWithEmailAndPassword(
          _email.text, _password.text);
    }
  }

  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    isLoggedIn = authService.isLoggedIn();
    setState(() {});
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await authService.signIn(_email.text, _password.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn
          ? MainScreen()
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Center(
                  child: OverflowBar(
                    overflowSpacing: 20,
                    children: [
                      TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is empty';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is empty';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Register'),
                          onPressed: () {
                            register();
                            setState(() {});
                            print(isLoggedIn);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () {
                            login();
                            setState(() {});
                            print(isLoggedIn);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
