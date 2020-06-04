import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Widgets Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Android Widgets Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      MethodChannel('example.flutter.innim.ru/android_widgets');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Builder(
          builder: (context) => RaisedButton(
            child: Text('Add widget'),
            onPressed: () async {
              String msg;
              try {
                final bool result = await platform.invokeMethod('addWidget');
                msg = result ? 'Widget added' : "Can't add widget";
              } on PlatformException catch (e) {
                msg = "Failed to add widget: '${e.message}'.";
              }

              Scaffold.of(context).showSnackBar(SnackBar(content: Text(msg)));
            },
          ),
        ),
      ),
    );
  }
}
