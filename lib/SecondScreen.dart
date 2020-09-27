import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hello_world/main.dart';

class SecondScreen extends StatefulWidget {
  SecondScreen({Key key}) : super(key: key);
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();
  String prblm;
  String email, password, name;

  @override
  initState() {
    nameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                    alignLabelWithHint: false,
                    hintText: "Enter your full Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[400], width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide(
                            color: Colors.blueAccent[400], width: 1.5))),
                controller: nameInputController,
                onChanged: (value) {
                  name = value; //get the value entered by user.
                },
                validator: (value) {
                  if (value.length < 3) {
                    return "Please enter a valid first name.";
                  }
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                onChanged: (value) {
                  email = value; //get the value entered by user.
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: new TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontStyle: FontStyle.italic),
                  hintText: "Enter Email id",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  alignLabelWithHint: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide:
                        BorderSide(color: Colors.blueAccent[400], width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    borderSide:
                        BorderSide(color: Colors.blueAccent[400], width: 1.5),
                  ),
                ),
                controller: emailInputController,
                validator: emailValidator,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontStyle: FontStyle.italic),
                    alignLabelWithHint: false,
                    hintText: "Enter Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide:
                          BorderSide(color: Colors.blueAccent[400], width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        borderSide: BorderSide(
                            color: Colors.blueAccent[400], width: 1.5))),
                validator: pwdValidator,
                controller: pwdInputController,
                onChanged: (value) {
                  password = value; //get the value entered by user.
                },
              ),
            ),
          ),
          FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: FlatButton(
                  onPressed: () async {
                    //displaySnackBar(context, "done");
                    setState(() {
                      //showProgress = true;
                    });
                    try {
                      if (email != null && password != null && name != null) {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        final FirebaseUser user = await _auth.currentUser();
                        final uid = user.uid;
                        displaySnackBar(context, uid.toString());
                        if (newuser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                          setState(() {
                            //showProgress = false;
                          });
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error creating account"),
                                content: Text(
                                    "Please enter your email address and password properly"),
                                actions: [
                                  FlatButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    } catch (e) {
                      prblm = e.toString();
                      displaySnackBar(context, prblm);
                    }
                  },
                  color: Colors.blueAccent[400],
                  child: new Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Sign In",
                      style: new TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.white),
                    ),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(40.0),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  displaySnackBar(BuildContext context, String mssg) {
    final snackBar = SnackBar(content: Text(mssg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
