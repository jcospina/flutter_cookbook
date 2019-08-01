import 'package:shared_preferences/shared_preferences.dart';

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
      home: SharedPreferencesDemo(title: appTitle,),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  final String title;

  SharedPreferencesDemo({Key key, this.title}): super(key: key);

  @override
  _SharedPreferencesDemoState createState() => _SharedPreferencesDemoState();
}

class _SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  int _counter;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  // Load counter value on start
  _loadCounter() async {
    // get prefs reference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
    });
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
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
      ),
    );
  }
}