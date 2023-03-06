// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SharedPreferencesExample(),
    );
  }
}

class SharedPreferencesExample extends StatefulWidget {
  const SharedPreferencesExample({super.key});

  @override
  State<SharedPreferencesExample> createState() =>
      _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  int _numberPref = 0;
  bool _boolPref = false;
  SharedPreferences? _prefs;
  static const String kNumberPrefKey = 'number_pref';
  static const String kBoolPrefKey = 'bool_pref';

  Future<Null> _setNumberPref(int value) async {
    await _prefs!.setInt(kNumberPrefKey, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async {
    await _prefs!.setBool(kBoolPrefKey, value);
    _loadBoolPref();
  }

  void _loadNumberPref() {
    setState(() {
      _numberPref = _prefs!.getInt(kNumberPrefKey) ?? 0;
    });
  }

  void _loadBoolPref() {
    setState(() {
      _boolPref = _prefs!.getBool(kBoolPrefKey) ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((value) {
      setState(() => _prefs = value);
      _loadNumberPref();
      _loadBoolPref();
    });
  }

  Future<Null> _resetDataPref() async {
    await _prefs!.remove(kNumberPrefKey);
    await _prefs!.remove(kBoolPrefKey);
    _loadNumberPref();
    _loadBoolPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preference'),
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(children: <Widget>[
                Text('Number Preference'),
                Text('${_numberPref}'),
                ElevatedButton(
                  child: Text('Increment'),
                  onPressed: () => _setNumberPref(_numberPref + 1),
                ),
              ]),
              TableRow(children: <Widget>[
                Text('Boolean Preference'),
                Text('${_boolPref}'),
                ElevatedButton(
                  child: Text('Toogle'),
                  onPressed: () => _setBoolPref(!_boolPref),
                ),
              ]),
            ],
          ),
          ElevatedButton(
            child: Text('Reset Data'),
            onPressed: () => _resetDataPref(),
          ),
        ],
      ),
    );
  }
}
