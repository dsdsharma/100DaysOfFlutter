import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform =
      const MethodChannel('com.example.batterylevel/battery');
  String _batterylevel = 'Unknown Battery Level';

  Future<void> _getBatteryLevel() async {
    String batterylevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batterylevel = "Battery level at $result %";
    } on PlatformException catch (e) {
      batterylevel = "Failed to get the battery level: $e";
    }
    setState(() {
      _batterylevel = batterylevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Battery Level Checker")),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
                onPressed: _getBatteryLevel, child: Text("Click Here")),
            Text(_batterylevel),
          ],
        ),
      ),
    );
  }
}
