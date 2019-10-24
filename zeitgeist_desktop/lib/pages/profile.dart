import 'package:flutter/material.dart';
import '../state/appState.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() { 
    super.initState();
    setTimesFromDB();
  }

  setTimesFromDB() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 150,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[Text("ProfilePhoto"), Text("Your Name")],
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(FeatherIcons.award),
                    Text("Your Awards")
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 300,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Icon(FeatherIcons.award),
                    Text("Your Awards")
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
