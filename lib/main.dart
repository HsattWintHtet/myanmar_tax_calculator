import 'package:flutter/material.dart';
import 'package:myanmar_tax_calculator/src/ui/splash_screen.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:firebase_remote_config/firebase_remote_config.dart';


void main() {
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = (FlutterErrorDetails details) {
    Crashlytics.instance.onError(details);
  };
  runApp(new MyMainApp());
}


Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  // Enable developer mode to relax fetch throttling
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  remoteConfig.setDefaults(<String, dynamic>{
    'welcome': 'default welcome',
    'hello': 'default hello',
  });
  return remoteConfig;
}


class MyMainApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Pyidaungsu',primarySwatch: blue),
      title: 'IRD Myanmar',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  static final MaterialColor blue = MaterialColor(
    0xFF0D47A1,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
