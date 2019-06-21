import 'package:flutter/material.dart';

void main() => runApp(MyTabApp());

class MyTabApp extends StatelessWidget {
  final appTitle = 'Tabs Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  icon: Icon(Icons.directions_boat),
                ),
                Tab(
                  icon: Icon(Icons.directions_bike),
                )
              ])
            ),
            body: TabBarView(children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_boat),
              Icon(Icons.directions_bike),
            ])
        ));
  }
}
