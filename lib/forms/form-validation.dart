import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String appTitle = 'Form Validation Demo';

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
    return Scaffold(appBar: AppBar(title: Text(title)), body: MyCustomForm());
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() => MyCustomFormState();
}

class MyCustomFormState extends State<MyCustomForm> {
  // Forms need a global key that uniquely identifies them and allow validation\
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  //Used to give focus to a text field programmatically
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myController.addListener(_updateTextValue);
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  _updateTextValue() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  focusNode: myFocusNode,
                  controller: myController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration(hintText: 'Enter a search term'),
                  autofocus: true,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                              // Hack to remove focus from the textfield and hide
                              // the keyboard
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            }
                          },
                          child: Text('Submit'),
                        ),
                        RaisedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(myFocusNode);
                          },
                          child: Text('Edit'),
                        ),
                      ],
                    )),
                Text(myController.text)
              ]),
        ));
  }
}
