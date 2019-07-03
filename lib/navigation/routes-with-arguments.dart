import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == PassArgumentsScreen.routeName) {
          final ScreenArguments args = settings.arguments;

          return MaterialPageRoute(builder: (context) {
            return PassArgumentsScreen(
                title: args.title, message: args.message);
          });
        }
      },
      title: 'Navigation with Arguments',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // A button that navigates to a named route that. The named route
            // extracts the arguments by itself.
            RaisedButton(
              child: Text('Navigate to screen that extracts arguments'),
              onPressed: () {
                // When the user taps the button, navigate to the specific route
                // and provide the arguments as part of the RouteSettings.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ExtractArgumentsScreen(),
                        // Pass the arguments as part of the RouteSettings. The
                        // ExtractArgumentScreen reads the arguments from these
                        // settings.
                        settings: RouteSettings(
                            arguments: ScreenArguments(
                                'Extract Arguments Screen',
                                'This message is extracted in the build method'))));
              },
            ),
            RaisedButton(
              child: Text('Navigate to a named that accepts arguments'),
              onPressed: () {
                Navigator.pushNamed(context, PassArgumentsScreen.routeName,
                    arguments: ScreenArguments('Accept Arguments Screen',
                        'This message is extracted in the onGenerateRoute function'));
              },
            )
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(args.title)),
        body: Center(child: Text(args.message)));
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const String routeName = '/passArguments';

  final String title;
  final String message;

  PassArgumentsScreen({Key key, @required this.title, @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)), body: Center(child: Text(message)));
  }
}

// You can pass any object to the arguments parameter.
// In this example, create a class that contains a customizable
// title and message.
class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}
