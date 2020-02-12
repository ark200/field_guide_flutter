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
  bool _saving = true;
  List data = [];
  var name = [];
  var sciname = [];
  var photograph =[];
  var url = [];
  var result;
  DateTime currentBackPressTime;


  void call() async{
    setState(() {
      _saving = true;
    });
    print("hsgjhg");
    var response = await   ApiCall.makeGetRequest("snake/all/");
    if(json.decode(response.body)["status"])
   setState(() {
     data = json.decode(response.body)["data"] as List;
     print(response.statusCode);
     print(data.length);
     _saving = false;
   });
    else
      setState(() {
        print("server error");
        _saving = false;
      });
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
    return WillPopScope(
      onWillPop: onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FIELD GUIDE',
        theme: ThemeData(
          primaryColor: Colors.white,
//          primarySwatch: Colors.white,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text('FIELD GUIDE'),),
          body:
          _saving ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),),):
              _myListView(context),
        ),
      ),
    );


//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'FieldGuide',
//      theme: ThemeData(
//          primaryColor: Colors.white
////        primarySwatch: Colors.white,
//      ),
//      home: Scaffold(
//        appBar: AppBar(title: Text('FIELD GUIDE'),),
////        body: Text('hi'),
//        body:
//        _saving ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),),):
//        _myListView(context),
//      ),
//    );
  }
  
  Future<bool> onWillPop()
  {
    DateTime now = DateTime.now();
    if(currentBackPressTime ==  null || now.difference(currentBackPressTime)>Duration(seconds: 2))
      {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Press Again to Exit Field Guide App");
        return Future.value(false);
      }
    return Future.value(true);
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
