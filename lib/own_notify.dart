
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'definitions.dart';

class OwnNotify {

  final MethodChannel _channel;

  factory OwnNotify() => _instance;

  @visibleForTesting
  OwnNotify.private(MethodChannel channel) : _channel = channel;

  static final OwnNotify _instance =
  OwnNotify.private(const MethodChannel(CHANNEL_FLUTTER_PLUGIN));

  Future<bool> initialize({bool debug = false}) async{
    WidgetsFlutterBinding.ensureInitialized();
        _channel.setMethodCallHandler(_handleMethod);
    var result = await _channel.invokeMethod(CHANNEL_METHOD_INITIALIZE, {
      INITIALIZE_DEBUG_MODE: debug,
    });

    return result;
  }

  Future<bool> showSomeDataFromNative() async{
    try{
      final bool wasCreated = await _channel.invokeMethod(CHANNEL_METHOD_SHOW_SOME_DATA);
      return wasCreated;
    } on PlatformException catch(error){
      print(error);
    }
    return false;
  }
//create Notification
  Future<bool> createNotification() async{
    try{
      final bool wasCreated = await _channel.invokeMethod(CHANNEL_METHOD_CREATE_NOTIFICATION);
      return wasCreated;
    } on PlatformException catch(error){
      print('CREATE NOTIFICATION: ${error}');
    }
    return false;
  }



   Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod(CHANNEL_METHOD_SHOW_PLATFROM_VERSION);
    return version;
  }





  Future <dynamic> _handleMethod(MethodCall call) async{
    Map<String, dynamic> arguments =
    (call.arguments as Map).cast<String, dynamic>();

    switch(call.method){

    }
  }
}
