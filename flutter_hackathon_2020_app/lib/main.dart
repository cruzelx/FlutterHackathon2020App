import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter_hackathon_2020_app/screens/createEventScreen.dart';
import 'package:flutter_hackathon_2020_app/screens/eventLocationMapScreen.dart';
import 'package:flutter_hackathon_2020_app/screens/eventScreen.dart';
import 'package:flutter_hackathon_2020_app/screens/loginWithGoole.dart';
import 'package:flutter_hackathon_2020_app/screens/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  return runApp(FlutterHackathon2020App());
}

class FlutterHackathon2020App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Volunteer App",
      home: VolunteerApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VolunteerApp extends StatefulWidget {
  @override
  _VolunteerAppState createState() => _VolunteerAppState();
}

class _VolunteerAppState extends State<VolunteerApp> {
  Future<List<dynamic>>getUserDetailFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    String email = prefs.getString("email");
    String photoUrl = prefs.getString("photoUrl");
    bool isLoggedIn = prefs.getBool("isLoggedIn");
    List<dynamic> userDetail = [username, email, photoUrl, isLoggedIn];
    return userDetail;
  }

  bool _isLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetailFromSP().then((value) {
      if (value[3] != null && value[3] != true){
        setState(() {
          _isLoggedIn = false;
        });
      }else{
        setState(() {
          _isLoggedIn=true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context)  {
    return LoginWithGoogleScreen();
  }
}
