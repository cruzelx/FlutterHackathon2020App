import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hackathon_2020_app/screens/mainPage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithGoogleScreen extends StatefulWidget {
  @override
  _LoginWithGoogleScreenState createState() => _LoginWithGoogleScreenState();
}

class _LoginWithGoogleScreenState extends State<LoginWithGoogleScreen> {
  final Widget loginImage = SvgPicture.asset(
    'assets/images/group.svg',
    semanticsLabel: 'App Logo',
  );

  final Widget googleLogo = SvgPicture.asset(
    'assets/images/googleIcon.svg',
    semanticsLabel: 'Google Logo',
  );

  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  _logIn() async {
    try {
      await _googleSignIn.signIn().catchError((e) {
        print(e);
      });
      setState(() {
        _isLoggedIn = true;
        print(_googleSignIn.currentUser);
        // storeUserDetailsToSP(
        //     _googleSignIn.currentUser.displayName,
        //     _googleSignIn.currentUser.email,
        //     _googleSignIn.currentUser.photoUrl,
        //     _isLoggedIn);
        Navigator.push(context,
            CupertinoPageRoute(builder: (BuildContext context) {
          return LandingPage();
        }));
      });
    } catch (err) {
      print(err);
    }
  }

  _logOut() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  storeUserDetailsToSP(
      String username, String email, String photoUrl, bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", username);
    prefs.setString("email", email);
    prefs.setString("photoUrl", photoUrl);
    prefs.setBool("isLoggedIn", isLoggedIn);
  }

  getUserDetailFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString("username");
    String email = prefs.getString("email");
    String photoUrl = prefs.getString("photoUrl");
    bool isLoggedIn = prefs.getBool("isLoggedIn");
    List<dynamic> userDetail = [username, email, photoUrl, isLoggedIn];
    print(userDetail);
    return userDetail;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 400.0,
          child: Column(
            children: <Widget>[
              Spacer(),
              Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.redAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: loginImage,
                  )),
              SizedBox(height: 10.0),
              Text("Helping Hands",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0)),
              SizedBox(height: 80.0),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: RaisedButton(
                  onPressed: () {
                    _logIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 28.0,
                        width: 28.0,
                        child: googleLogo,
                      ),
                      Text("Login with Google",
                          style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    ));
  }
}
