import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() =>
    runApp(MyApp(items: List<String>.generate(10000, (i) => "Item $i")));

/*
The standard ListView constructor works well for small lists. To work with lists 
that contain a large number of items, it’s best to use the ListView.builder 
constructor.
In contrast to the default ListView constructor, which requires creating all 
items at once, the ListView.builder() constructor creates items as they’re 
scrolled onto the screen.
*/

class MyApp extends StatelessWidget {
  final List<String> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${items[index]}')
              );
            }
        ),
      ),
    );
  }
}
