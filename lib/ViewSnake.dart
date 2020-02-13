import 'dart:convert';
import 'package:field_guide/NetworkCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewSnake extends StatefulWidget
{
  var index;
  ViewSnake(this.index);
  @override
  _ViewSnake createState() => _ViewSnake(this.index);
}

class _ViewSnake extends State<ViewSnake>
{
  var index;
  _ViewSnake(this.index);
  bool _saving = true;
  List data = [];

  void call() async
  {
//    print(widget.index);
    setState(() {
      _saving = true;
    });
    var response = await ApiCall.makeGetRequest("snake/all/");
    if(json.decode(response.body)["status"])
      setState(() {
        data = json.decode(response.body)["data"] as List;
        _saving = false;
      });
    else
    {
      setState(() {
        print("server error");
        _saving = false;
      });
    }
  }

  @override
  void initState()
  {
    call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Snake",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
//        appBar: AppBar(
//
//        ),
        body:
        _saving ? Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ):
        _snakeview(context),
      ),
    );
  }

  Widget _snakeview(BuildContext context)
  {
    return Scaffold(
      body:
        SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 280,
                  child: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["photographs"][0]["url"]),
                  height: 280,
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(data[index]["name"].toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),

                Center(
                  child: Text(data[index]["scientificName"].toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontSize: 16
                  ),
                  ),
                )
              ],

            ),
          ),
        )
//      Container(
//        child: SingleChildScrollView(
//          child: Container(
//            padding: EdgeInsets.all(2),
//            child: SizedBox(
//              height: 280,
//              child: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["photographs"][0]["url"]),
//                height: 280,
//                width: double.infinity,
//                fit: BoxFit.fitWidth,
//              ),
//            ),
//
//          ),
//        ),
//      ),
    );
  }
}