import 'dart:async';
import 'package:field_guide/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    super.initState();
    Timer(
      Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context)=> LoginScreen()
        ))
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Image.asset('Images/isi.png'),
      ),
    );
  }

}