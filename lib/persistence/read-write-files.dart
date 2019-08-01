import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Read/Write File Demo';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: ReadWriteFileDemo(title: appTitle, storage: CounterStorage()),
    );
  }
}

class CounterStorage {
  // Get the platform specific documents directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

    // Create File reference
  Future<File> get _locaLFile async {
      final path = await _localPath;
      return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _locaLFile;

      // Read the file
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch(e) {
      // If encountering an error return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _locaLFile;

    // Write the file
    return file.writeAsString('$counter');
  }

}

class ReadWriteFileDemo extends StatefulWidget {
  final String title;
  final CounterStorage storage;

  ReadWriteFileDemo({Key key, @required this.title, @required this.storage})
      : super(key: key);

  @override
  _ReadWriteFileDemoState createState() => _ReadWriteFileDemoState();
}

class _ReadWriteFileDemoState extends State<ReadWriteFileDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    widget.storage.readCounter().then((int value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });
    // write the variable as string to the file
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Text(
          'Button tapped $_counter time${_counter == 1 ? '' : 's'}'
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add)
      )
    );
  }
}