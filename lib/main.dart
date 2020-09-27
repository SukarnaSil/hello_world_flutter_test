import 'package:flutter/material.dart';
import 'SecondScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeScreen createState() => HomeScreen();
}

class Battalion {
  int value;
  String name;

  Battalion(this.value, this.name);
}

class Strength {
  int value;
  String name;

  Strength(this.value, this.name);
}

class HomeScreen extends State<Home> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final dbRef = FirebaseDatabase.instance.reference();

  List<Battalion> _dropdownItems = [
    Battalion(1, "SAP 1st Battalion"),
    Battalion(2, "SAP 2nd Battalion"),
    Battalion(3, "SAP 3rd Battalion"),
    Battalion(4, "SAP 4th Battalion"),
    Battalion(5, "SAP 6th Battalion"),
    Battalion(6, "SAP 7th Battalion"),
    Battalion(7, "SAP 8th Battalion")
  ];

  List<Strength> _dropdownItemsStrength = [
    Strength(1, "Available Strength"),
    Strength(2, "Actual Strength"),
    Strength(3, "Vacancy"),
  ];

  List<DropdownMenuItem<Battalion>> _dropdownMenuItems;
  Battalion _selectedBattalion;

  List<DropdownMenuItem<Strength>> _dropdownMenuItemsList;
  Strength _selectedStrength;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedBattalion = _dropdownMenuItems[0].value;

    _dropdownMenuItemsList = buildDropDownMenuStrngth(_dropdownItemsStrength);
    _selectedStrength = _dropdownMenuItemsList[0].value;
  }

  // ignore: non_constant_identifier_names
  List<DropdownMenuItem<Battalion>> buildDropDownMenuItems(List Battalions) {
    List<DropdownMenuItem<Battalion>> items = List();
    for (Battalion battalion in Battalions) {
      items.add(
        DropdownMenuItem(
          child: Text(battalion.name),
          value: battalion,
        ),
      );
    }
    return items;
  }

  // ignore: non_constant_identifier_names
  List<DropdownMenuItem<Strength>> buildDropDownMenuStrngth(List Strengths) {
    List<DropdownMenuItem<Strength>> strengthItems = List();
    for (Strength strength in Strengths) {
      strengthItems.add(
        DropdownMenuItem(
          child: Text(strength.name),
          value: strength,
        ),
      );
    }
    return strengthItems;
  }

  // ignore: unused_field
  int _value = 1;
  String itemVal, result;
  TextEditingController num1controller = new TextEditingController();
  TextEditingController num2controller = new TextEditingController();
  TextEditingController num3controller = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  gotoSecondActivity(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dropdown Button"),
      ),
      backgroundColor: Colors.grey[350],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey,
                border: Border.all()),
            child: DropdownButton<Battalion>(
                value: _selectedBattalion,
                items: _dropdownMenuItems,
                onChanged: (battalion) {
                  setState(() {
                    _selectedBattalion = battalion;
                  });
                }),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey,
                border: Border.all()),
            child: DropdownButton<Strength>(
                value: _selectedStrength,
                items: _dropdownMenuItemsList,
                onChanged: (strength) {
                  setState(() {
                    _selectedStrength = strength;
                  });
                }),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "COMMANDANT :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: num1controller,
                            decoration: InputDecoration(
                              hintText: "02",
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            )),
                      ),
                    )),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "DEPUTY COMMANDANT :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child: TextField(
                            controller: num2controller,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "02",
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            )),
                      ),
                    )),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: new Text(
                  "Assistant Commandant",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 100.0,
                        height: 50.0,
                        child: TextField(
                            controller: num3controller,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: "02",
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white70,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            )),
                      ),
                    )),
              )
            ],
          ),
          FlatButton(
            onPressed: ()
                /*setState(() {
                int sum = int.parse(num1controller.text) +
                    int.parse(num2controller.text);
                result = sum.toString();
                displaySnackBar(context);
              });*/
                //gotoSecondActivity(context);
                async {
              final FirebaseUser user = await _auth.currentUser();
              final uid = user.uid;
              displaySnackBar(context, uid);
              dbRef.child(uid).set({
                "name": "Sukarna Sil",
                "email": "sukarnasil11@gmail.com",
              }).then((_) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Successfully Added')));
              }).catchError((onError) {
                print(onError);
              });
            },
            color: Colors.black,
            child: Text("Calculate", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  displaySnackBar(BuildContext context, String mssg) {
    final snackBar = SnackBar(content: Text(mssg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
