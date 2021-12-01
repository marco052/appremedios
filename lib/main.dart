import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharmacy_wiki/modules/notifications/notification_service.dart';
import 'package:pharmacy_wiki/modules/splash/splash_page.dart';
import 'package:pharmacy_wiki/shared/services/local_notification.dart';
import 'package:pharmacy_wiki/shared/services/sensors_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification().initilizate();

  SensorManager().accelerometerSubscribe();
  // SensorManager().scheduleUnsubscribe(Duration(seconds: 10));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
