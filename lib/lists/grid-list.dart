import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final random = Random();
  final title = 'Grid List';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
            appBar: AppBar(title: Text(title)),
            body: GridView.count(
                // Creates a grid with 2 columns
                crossAxisCount: 4,
                children: List.generate(200, (index) {
                  return Container(
                    color: Color.fromRGBO(random.nextInt(256),
                        random.nextInt(256), random.nextInt(256), 1),
                  );
                })
            )
        )
    );
  }
}
