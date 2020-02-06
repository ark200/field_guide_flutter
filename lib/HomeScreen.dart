import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
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
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context)
{
  final titles = ['bike','boat','bus','car'];
  final icons = [Icons.directions_bike, Icons.directions_boat, Icons.directions_bus, Icons.directions_car];
  final subtitle = ['roadways','seaways','roadways','four wheeler'];
  return ListView.builder(
    itemCount: titles.length,
    itemBuilder: (context, index)
    {
      return Card(
        child: ListTile(
          leading: Icon(icons[index]),
          title: Text(titles[index]),
          subtitle: Text(subtitle[index]),
        ),
      );
    },
  );
}