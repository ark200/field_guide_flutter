import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
      home: SplashScreen(),
    );
  }
}