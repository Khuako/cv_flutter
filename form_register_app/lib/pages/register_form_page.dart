// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../styles/textfield_styles.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({super.key});

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  List<String> _countries = ['Russia', 'USA', 'Canada', 'UK'];
  String? _selectedCountry;

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A_Za-z]+$');
    if (value!.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetic symbols';
    } else
      return null;
  }

  bool _validatePhoneNumber(String? input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\d\d$');
    return _phoneExp.hasMatch(input!);
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    } else if (!value.contains('@')) {
      'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passController.text != _confPassController.text) {
      return 'Password does not match';
    } else
      return null;
  }

  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print("Name: ${_nameController.text}");
      print("Phone: ${_phoneController.text}");
      print("Email: ${_emailController.text}");
      print("Life Story: ${_storyController.text}");
      print("Password: ${_passController.text}");
      print("Country: ${_selectedCountry}");
      print("ConfirmedPassword: ${_confPassController.text}");
    } else
      print('Form is not valid');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form Page'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              validator: _validateName,
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name *',
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: TextFieldStyles.enabled,
                focusedBorder: TextFieldStyles.focused,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone number *',
                hintText: 'Where can we reach you?',
                helperText: 'Phone Format: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.phone),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                enabledBorder: TextFieldStyles.enabled,
                focusedBorder: TextFieldStyles.focused,
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                // FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true),
              ],
              validator: (value) => _validatePhoneNumber(value)
                  ? null
                  : 'Phone number must be entered as(###)###-####',
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'Enter your email address',
                icon: Icon(Icons.email),
              ),
              validator: _validateEmail,
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.map),
                    labelText: 'Country?'),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    child: Text(country),
                    value: country,
                  );
                }).toList(),
                onChanged: (data) {
                  print(data);
                  setState(() {
                    _selectedCountry = data!;
                  });
                },
                // validator: (val) {
                //   val == null ? 'Please select a country' : null;
                // },
                value: _selectedCountry),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: 'Life Story',
                hintText: 'Tell us about yourself',
                helperText: 'Keep it short.',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password*',
                icon: Icon(Icons.security),
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
              validator: _validatePassword,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _confPassController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                icon: Icon(Icons.border_color),
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
              ),
              validator: _validatePassword,
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
              ),
              onPressed: _submitForm,
              child: Text(
                'Submit Form',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
