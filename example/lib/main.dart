import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:own_notify/own_notify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OwnNotify().initialize(debug: true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Not Knownclear';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
     /* platformVersion =
          await OwnNotify. ?? 'Unknown platform version';*/
      _platformVersion = await OwnNotify().platformVersion ?? "unknowm platform version: main.dart";
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      platformVersion = _platformVersion;
    });
  }

  Future<void> _showNotification() async{
    bool result;
    try{
      OwnNotify().createNotification();

    }on PlatformException {
      result = false;
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("dsf", textAlign: TextAlign.center,),
              ElevatedButton(onPressed: (){
                _showNotification();
              }, child: Text("show Notification"))
            ],
          ),
        ),
        // body: Center(
        //   child: Text('Running on: $_platformVersion\n'),
        // ),
      ),
    );
  }
}


