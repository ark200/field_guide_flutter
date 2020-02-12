import 'dart:async';
import 'package:field_guide/HomeScreen.dart';
import 'package:field_guide/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  var token;
  @override
  void initState() async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString('username');
    super.initState();
    Timer(
      Duration(seconds: 3),
        () =>token ==null ? Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context)=> LoginScreen()
        )):
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context)=> HomeScreen()
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