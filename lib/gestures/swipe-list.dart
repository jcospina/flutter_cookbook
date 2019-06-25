import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  final String appTitle = 'Swipe to dismiss demo';

  @override
  MyAppState createState() => MyAppState(title: appTitle);
}

class MyAppState extends State<MyApp> {
  MyAppState({Key key, this.title});

  final String title;
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets
                    key: Key(item),
                    // the background is the leave behind shown after the dismiss
                    background: Container(color: Colors.red),
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('$item dismissed'),
                          action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                setState(() {
                                  items.insert(index, item);
                                });
                              })));
                    },
                    child: ListTile(title: Text('$item')));
              }),
        ));
  }
}
