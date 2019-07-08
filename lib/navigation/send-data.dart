import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Todo {
  final String title;
  final String description;

  Todo(this.title, this.description);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send data to screen',
      home: TodosScreen(
        todos: List.generate(
            20,
            (i) => Todo('Todo $i',
                'A description of what needs to be done for Todo $i')),
      ),
    );
  }
}

class TodosScreen extends StatelessWidget {
  final List<Todo> todos;

  TodosScreen({Key key, @required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(todos[index].title),
              // When a user taps the ListTile, navigate to the DetailsScreen.
              // Notice that you're not only creating a DetailsScreen, you're
              // also passing the currentTodo through to it
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(todo: todos[index])));
              },
            );
          }),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Todo todo;

  DetailsScreen({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(todo.title)),
        body: Padding(
            padding: EdgeInsets.all(16.0), child: Text(todo.description)));
  }
}
