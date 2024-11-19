import 'package:flutter/material.dart';
import 'package:flutter_h5/base/js2flutter_by_url.dart';

import 'base/flutter2js_by_runJavascript.dart';
import 'base/flutter2js_by_url.dart';
import 'base/js2flutter_by_channel.dart';
import 'jump/flutter_h5_jump_asset.dart';
import 'jump/flutter_h5_jump_html_file.dart';
import 'login/flutter_h5_login_sync_by_cookie.dart';
import 'login/flutter_h5_sync_by_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _navButton(context, JS2FlutterByUrl(), "JS2FlutterByUrl"),
            _navButton(context, JS2FlutterByChannel(), "JS2FlutterByChannel"),
            _navButton(context, Flutter2JSByUrl(), "Flutter2JSByUrl"),
            _navButton(context, Flutter2JsByRunJavascript(),
                "Flutter2JsByRunJavascript"),
            _navButton(context, FlutterH5JumpAsset(), "FlutterH5JumpAsset"),
            _navButton(
                context, FlutterH5JumpHtmlFile(), "FlutterH5JumpHtmlFile"),
            _navButton(context, FlutterH5LoginCookie(), "FlutterH5LoginCookie"),
            _navButton(
                context, FlutterH5LoginChannel(), "FlutterH5LoginChannel")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _navButton(BuildContext context, Widget page, String title) {
    return FilledButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => page));
        },
        child: Text(title));
  }
}
