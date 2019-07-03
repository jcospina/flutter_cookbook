import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // when defining initialRoute we don't define a home property
      initialRoute: '/',
      routes: {
        // when navigating to '/' build the FirstScreen widget
        '/': (context) => FirstRoute(),
        // When navigating to '/second' build the SecondRoute widget
        '/second': (context) => SecondRoute()
      },
    );
  }
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Main Screen')),
        body: Center(
            child: RaisedButton(
                child: Text('Open route'),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                })));
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Route')),
      body: Center(
        child: RaisedButton(child: Text('Go back'), onPressed: () {
          Navigator.pop(context);
        }),
      ),
    );
  }
}
