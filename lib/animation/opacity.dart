import 'package:flutter/material.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('AnimatedContainer Demo')),
            body: Center(
                child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.green,
                    ))),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.flip),
              onPressed: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              tooltip: 'Toggle Opacity',
            )));
  }
}
