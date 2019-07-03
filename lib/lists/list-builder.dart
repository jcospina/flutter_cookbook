import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp(
        items: List<ListItem>.generate(60, (i) {
      return i % 6 == 0
          ? HeadingItem("Heading $i")
          : MessageItem("Sender $i", "Message body $i");
    })));

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  MyApp({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Mixed List';
    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                // Logic to decide which widget to display depending on the data
                final item = items[index];

                if (item is HeadingItem) {
                  return ListTile(
                      title: Text(item.heading,
                          style: Theme.of(context).textTheme.headline));
                } else if (item is MessageItem) {
                  return ListTile(
                      title: Text(item.sender), subtitle: Text(item.body));
                }
              })),
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}
