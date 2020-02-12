import 'package:field_guide/HomeScreen.dart';
import 'package:field_guide/NetworkCall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget
{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginScreen>
{
  final formkey = GlobalKey<FormState>();
  var username, password;
  DateTime currentBackPressTime;
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body:
        _saving ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),),):
        Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Center(
                child: Form(
                  key: formkey,
                  child: new Theme(
                    data: new ThemeData(
                      primaryColor: Colors.green,
                      primaryColorDark: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('Images/login.png'),
                          ),
                        ),
                        TextFormField(
                          autofocus: false,
                          onSaved: (name)
                          {
                            username = name;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (uname)
                          {
                            if(uname.isEmpty)
                              {
                                return "PLEASE ENTER THE USERNAME";
                              }
                            return null;
                          },

                          decoration: InputDecoration(
                            labelText: "Username",
                            hintText: "username",
                            prefixIcon: Icon(Icons.account_circle),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(
                                width: 1,
                                style: BorderStyle.none,
                                color: Colors.green
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          autofocus: false,
                          onSaved: (pass)
                          {
                            password = pass;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (pass)
                          {
                            if(pass.isEmpty)
                              {
                                return "PLEASE ENTER THE PASSWORD";
                              }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "password",
                            prefixIcon: Icon(Icons.lock),
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.green,
                                style: BorderStyle.none
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          child: MaterialButton(
                            onPressed: () async
                            {
                              if(formkey.currentState.validate())
                                {
                                  setState(() {
                                    _saving = true;
                                  });

                                  formkey.currentState.save();

                                  Map data = {
                                    'username':username,
                                    'password': password
                                  };

                                  var response = await ApiCall.makePostRequest("user/login",sendData: data);
                                  if(response.statusCode == 200)
                                    {
                                      setState(() {
                                        Fluttertoast.showToast(msg: "LOGIN SUCCESS");
                                        Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
                                          builder: (BuildContext context)
                                              {
                                                _saving = false;
                                                return HomeScreen();
                                              }
                                        ));
                                      });
//                                      Fluttertoast.showToast(msg: "LOGIN SUCCESS");
//                                      Navigator.of(context).pushReplacement(MaterialPageRoute<Null>(
//                                        builder: (BuildContext context)
//                                            {
//                                              return HomeScreen();
//                                            }
//                                      ));
                                    }
                                  else
                                    {
                                      _saving = false;
                                      Fluttertoast.showToast(msg: "Incorrect Username or password");
                                    }
                                }
                            },
                            textColor: Colors.white,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                              side: BorderSide(color: Colors.green)
                            ),
                            height: 50,
                            child: Text("SIGN IN"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>         Fluttertoast.showToast(msg: "COMING SOON"),
//                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen())),
                            child: Text("Sign Up",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () =>         Fluttertoast.showToast(msg: "COMING SOON"),

//                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen())),
                              child: Text("Forgot Password?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> onWillPop()
  {
    DateTime now = DateTime.now();
    if(currentBackPressTime == null || now.difference(currentBackPressTime)>Duration(seconds: 2))
      {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: "Press Again to Exit Indian Snakes App");
        return Future.value(false);
      }
    return Future.value(true);
  }
}