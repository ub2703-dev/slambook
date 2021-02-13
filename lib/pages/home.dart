import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:slambook/pages/activityFeed.dart';
import 'package:slambook/pages/profile.dart';
import 'package:slambook/pages/search.dart';
import 'package:slambook/pages/timeline.dart';
import 'package:slambook/pages/upload.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  int _currentIndexState = 0;
  List<Widget> _children = [
    TimeLine(),
    ActivityFeed(),
    Upload(),
    Search(),
    Profile()
  ];


  void initState(){
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((account) {
      if(account != null){
        setState(() {
          isAuth = true;
        });
      } else{
        setState(() {
          isAuth = false;
        });
      }
    });

    googleSignIn.signInSilently().then((account){
      if(account != null){
        setState(() {
          isAuth = true;
        });
      } else{
        setState(() {
          isAuth = false;
        });
      }
    });

  }


  login(){
    googleSignIn.signIn();
  }

  logout(){
    googleSignIn.signOut();
  }

  Widget buildAuthScreen() {
    return Scaffold(

      body: _children[_currentIndexState],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndexState,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'TimeLine'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'TimeLine'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'TimeLine'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'TimeLine'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded), label: 'TimeLine'),
        ],
        onTap: (index){
          _currentIndexState = index;
        },

      ),
    );
  }

  Scaffold buildUnauthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).accentColor,
            ])),
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'SlamBook',
                style: TextStyle(
                  fontFamily: 'Signatra',
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: login,
                child: Container(
                  width: 260,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  )),
                ),
              )
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnauthScreen();
  }
}
