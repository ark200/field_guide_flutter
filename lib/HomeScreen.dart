import 'dart:convert';
import 'package:field_guide/LoginScreen.dart';
import 'package:field_guide/NetworkCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewSnake.dart';

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
  var states = [];
  var lookalike = [];
  var _id = [];
  var distribution = [];
  var venomtype = [];
  var family = [];
  var characteristics = [];
  var description = [];
  var rname = [];
  var wlpa =[];
  var iucn = [];
  var shortdesc = [];
  var occurance = [];
  var othernames = [];
  var genus = [];
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
          appBar: AppBar(title: Text('FIELD GUIDE'),
          backgroundColor: Colors.white,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.black,
              child: Text("LOGOUT"),
              onPressed: () async
              {
                SharedPreferences preference = await SharedPreferences.getInstance();
                preference.remove('username');
                Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
                    builder: (BuildContext context)
                    {
                      _saving = false;
                      return LoginScreen();
                    }
                ));
              },
            )
          ],
          ),


          body:
          _saving ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),),):
              _myListView(context),
        ),
      ),
    );
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

//  _viewsnakeProfile(var index1)
//  {
//    return Scaffold(
//      body:
//      Container(
//        child: SingleChildScrollView(
//          child: Container(
//            padding: EdgeInsets.all(20),
//            child: SizedBox(
//              height: 150,
//              child: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index1]["photographs"][0]["url"])),
//            ),
//
//          ),
//        ),
//      ),
//    );
//  }

  Widget _myListView(BuildContext context)
  {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder:(context, index)
      {
//        states           = data[index]["states"];
//        lookalike        = data[index]["lookalike"];
//        _id              = data[index]["_id"];
//        distribution     = data[index]["distribution"];
//        family           = data[index]["family"];
//        characteristics  = data[index]["characteristics"];
//        description      = data[index]["description"];
//        rname            = data[index]["rname"];
//        wlpa             = data[index]["wlpa"];
//        iucn             = data[index]["iucn"];
//        shortdesc        = data[index]["shortdesc"];
//        occurance        = data[index]["occurance"];
//        othernames       = data[index]["othernames"];
//        genus            = data[index]["genus"];
        photograph       = data[index]["photographs"];
        if(photograph.length>0)
        {
          return SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            maintainBottomViewPadding: false,
            child: Card(
              child: InkWell(
                onTap: ()
                {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ViewSnake(index)));
                },
                child: ListTile(
                  leading: Image(image: NetworkImage("http://18.191.40.18/u/"+data[index]["photographs"][0]["url"]),
                  width: 100,
                    height: 100,
                  ),
                  title: Text(data[index]["name"]),
                  subtitle: Text(data[index]["scientificName"]),
                  trailing: Icon(Icons.arrow_right),

                ),
              ),
            ),
          );
        }
        else
        {
          return SafeArea(
            child: Card(
              child: InkWell(
                onTap: ()
                {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => ViewSnake(index)));
//                  _viewsnakeProfile(index);
                },
                child: ListTile(
                  leading: Image(image: AssetImage("Images/noiamge.png"),
                  height: 100,
                    width: 100,
                  ),
                  title: Text(data[index]["name"]),
                  subtitle: Text(data[index]["scientificName"]),
                  trailing: Icon(Icons.arrow_right),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
