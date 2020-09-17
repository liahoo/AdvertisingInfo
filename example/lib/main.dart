import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:advertising_info/advertising_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AdvertisingInfo _advertisingInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    AdvertisingInfo advertisingInfo;
    try {
      advertisingInfo = await AdvertisingInfo.read();
    } on PlatformException {
      advertisingInfo = null;
    }

    if (!mounted) return;

    setState(() {
      _advertisingInfo = advertisingInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('advertising id:'),
              Text(
                '${_advertisingInfo?.id}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text('isLimitAdTrackingEnabled:'),
              Text(
                '${_advertisingInfo?.isLimitAdTrackingEnabled}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text('authorizationStatus:'),
              Text(
                '${_advertisingInfo?.authorizationStatus}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
