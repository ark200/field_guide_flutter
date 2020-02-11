import 'dart:convert';
import 'package:field_guide/NetworkCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  
  List data = [];
  var name = [];
  var sciname = [];
  var url = [];
  var result;


  void call() async{
    print("hsgjhg");
    var response = await   ApiCall.makeGetRequest("snake/all/");

    if(json.decode(response.body)["status"]) {
  setState(() {
  data = json.decode(response.body)["data"] as List;
  print(response.statusCode);
  print(data.length);
  });
    }

    else
      print("server error");

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
      title: 'FieldGuide',
      theme: ThemeData(
        primaryColor: Colors.white
//        primarySwatch: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('FIELD GUIDE'),),
//        body: Text('hi'),
        body: _myListView(context),
      ),
    );
  }

  Widget _myListView(BuildContext context)
  {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder:(context, index)
      {
        return Card(
          child: InkWell(
            onTap: (){

            },
            child: ListTile(
//              leading: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["url"]),),
              leading: Image(image:AssetImage("Images/isi.png")),
//              leading: Icon(Icons.image),
              title: Text(data[index]["name"]),
              subtitle: Text(data[index]["scientificName"]),
            ),
          ),
        );
      },
    );
  }
}


