import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:my_flutter_plugin/my_flutter_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _batteryPer = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initBattery();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MyFlutterPlugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBattery() async {
    String battery;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      battery = await MyFlutterPlugin.batteryPercent;
    } on PlatformException {
      battery = 'Failed to get battery percent.';
    }

    if (!mounted) return;

    setState(() {
      _batteryPer = battery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: new RaisedButton(
                  child: new Text('Update'),
                  onPressed: _updateMethod(),
                ),
              ),
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              Center(
                child: Text('Battery is: $_batteryPer\n'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateMethod() {
    initBattery();
  }
}
