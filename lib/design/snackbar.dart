import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'Snackbar Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: appTitle, home: MyHomePage(title: appTitle));
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: SnackBarPage());
  }
}

class SnackBarPage extends StatelessWidget {
  final snackBar = SnackBar(
    content: Text('Yay! A SnackBar!'),
    action: SnackBarAction(label: 'Undo', onPressed: () {}),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RaisedButton(
            onPressed: () {
              Scaffold.of(context).showSnackBar(snackBar);
            },
            child: Text('Show SnackBar')));
  }
}
