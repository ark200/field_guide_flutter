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
  var photograph =[];
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
        photograph = data[index]["photographs"];
        if(photograph.length>0)
        {
          return Card(
            child: InkWell(
              onTap: ()
              {

              },
              child: ListTile(
                leading: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["photographs"][0]["url"]),
                  width: 100,
                  height: 100,),
                title: Text(data[index]["name"]),
                subtitle: Text(data[index]["scientificName"]),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          );
        }
        else
        {
          return Card(
            child: InkWell(
              onTap: ()
              {

              },
              child: ListTile(
                leading: Image(image: AssetImage("Images/noiamge.png"),
                  height: 100,
                  width: 100,),
//                  leading: Icon(Icons.image),
                title: Text(data[index]["name"]),
                subtitle: Text(data[index]["scientificName"]),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          );
        }
//        return Card(
//          child: InkWell(
//            onTap: (){
//
//            },
//            child: ListTile(
////              leading: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["photographs"[0]]["url"]),),
//              leading: Image(image:AssetImage("Images/isi.png")),
////              leading: Icon(Icons.image),
//              title: Text(data[index]["name"]),
//              subtitle: Text(data[index]["scientificName"]),
//
//            ),
//          ),
//        );
      },
    );
  }
}
