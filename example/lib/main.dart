import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:umeng/umeng.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    getVersionName();
    initUmeng();
    initPlatformState();
  }
  void getVersionName()async{
    final PackageInfo info = await PackageInfo.fromPlatform();
    print("version: ${info.version}");
  }
  void initUmeng()async{
    //TODO
    await Umeng.init("androidKey", "iosKey", "", onlineParamEnabled: true);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Umeng.platformVersion;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: getOnlineParam,
            child: Text('Running on: $_platformVersion\n'),
          ),
        ),
      ),
    );
  }
  void getOnlineParam()async{
    //TODO
    String onlineParam = await Umeng.getOnlineParam("onlineParam");
    print("onlineParam: $onlineParam");
  }
}
