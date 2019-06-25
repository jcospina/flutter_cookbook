import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Tap Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MyRippleButton(),
                MyGestureDetectorButton()
              ],
          )
        )
    );
  }
}

class MyRippleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inkwell provides the material animation for any clickable widget
    // allowing us to create custom material widgets
    return InkWell(
      onTap: () {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Tap on custom material button')));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Ripple'),
      ),
    );
  }
}

class MyGestureDetectorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Inkwell provides the material animation for any clickable widget
    // allowing us to create custom material widgets
    return GestureDetector(
      onTap: () {
        Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Tap on gesture detector button')));
      },
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text('Gesture Detector'),
      ),
    );
  }
}
