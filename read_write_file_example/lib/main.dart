// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
      home: ReadWriteFileExample(),
    );
  }
}

class ReadWriteFileExample extends StatefulWidget {
  const ReadWriteFileExample({super.key});

  @override
  State<ReadWriteFileExample> createState() => _ReadWriteFileExampleState();
}

class _ReadWriteFileExampleState extends State<ReadWriteFileExample> {
  final TextEditingController _textController = TextEditingController();
  static const String kLocalFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = kLocalFileName;
  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void initState() {
    super.initState();
    _readTextFromLocalFile();
    _getLocalFile.then(
      (value) => setState(
        () => _localFilePath = value.path,
      ),
    );
  }

  Future<File> get _getLocalFile async {
    final path = await _getLocalPath;
    return File('$path/$kLocalFileName');
  }

  Future<File> _writeTextToLocalFile(String text) async {
    final file = await _getLocalFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocalFile() async {
    String content;
    try {
      final file = await _getLocalFile;
      content = await file.readAsString();
    } catch (e) {
      content = 'Error loading local file: $e';
    }
    setState(() {
      _localFileContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text('Local file read/write Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          Text(
            'Write to local file:',
            style: TextStyle(fontSize: 20),
          ),
          TextField(
            focusNode: textFieldFocusNode,
            controller: _textController,
            maxLines: null,
            style: TextStyle(fontSize: 20),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        child: Text('Load', style: TextStyle(fontSize: 20)),
                        onPressed: () async {
                          _readTextFromLocalFile();
                          _textController.text = _localFileContent;
                          FocusScope.of(context)
                              .requestFocus(textFieldFocusNode);
                          log('String succesfully loaded from local file');
                        },
                      ),
                      MaterialButton(
                        child: Text('Save', style: TextStyle(fontSize: 20)),
                        onPressed: () async {
                          await _writeTextToLocalFile(_textController.text);
                          _textController.clear();
                          await _readTextFromLocalFile();
                          log('String succesfully written from local file');
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(height: 20.0),
                      Text('Local file path:',
                          style: Theme.of(context).textTheme.headline6),
                      Text(_localFilePath,
                          style: Theme.of(context).textTheme.subtitle1),
                      Divider(height: 20.0),
                      Text('Local file content:',
                          style: Theme.of(context).textTheme.headline6),
                      Text(_localFileContent,
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
