import 'package:flutter/material.dart';
import 'package:flutter_project_1/Theme/button_style_widget.dart';
import 'package:flutter_project_1/Theme/styles.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Login to your account"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            children: [
              const SizedBox(
                height: 25,
              ),
              _FormWidget(),
              const SizedBox(
                height: 25,
              ),
              _HeaderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        const Text(
          "In order to use the editing and rating capabilities of TMDB, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started.",
          style: authText,
        ),
        const SizedBox(
          height: 5,
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Register"),
          style: AppButtonStyle.linkButton,
        ),
        const SizedBox(
          height: 25,
        ),
        const Text(
            "If you signed up but didn't get your verification email, click here to have it resent.",
            style: authText),
        const SizedBox(
          height: 5,
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Verify Email"),
          style: AppButtonStyle.linkButton,
        ),
      ],
    );
  }
}

class _FormWidget extends StatefulWidget {
  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

const colorY = Color(0xFF01B4E4);

class __FormWidgetState extends State<_FormWidget> {
  String? errorText = null;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  void _auth() {
    final login = _loginController.text;
    final password = _passwordController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;
    } else {
      errorText = "Неверный Логин или Пароль";
    }
    setState(() {});
  }

  void _resetPassword() {
    print("Reset password");
  }

  final inputDec = const InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 2),
    ),
    isCollapsed: true,
  );
  @override
  Widget build(BuildContext context) {
    final errorText = this.errorText;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null)
          Text(
            errorText,
            style: TextStyle(color: Colors.red),
          ),
        SizedBox(
          height: 10,
        ),
        const Text(
          'Username',
          style: authText,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _loginController,
          cursorColor: Colors.black,
          cursorWidth: 1.5,
          cursorHeight: 23,
          decoration: inputDec,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Password',
          style: authText,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          controller: _passwordController,
          cursorColor: Colors.black,
          cursorWidth: 1.5,
          cursorHeight: 23,
          decoration: inputDec,
          obscureText: true,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            TextButton(
              onPressed: _auth,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(colorY),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text(
                "Login",
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text("Reset password"),
            ),
          ],
        )
      ],
    );
  }
}
