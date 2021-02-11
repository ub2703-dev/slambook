import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isAuth = false;

  Widget buildAuthScreen(){
    return Text('User is Authenticated');
  }

  Scaffold buildUnauthScreen(){

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
              colors: [
                Colors.teal,
                Colors.purple,
            ]
          )
        ),
        alignment: Alignment.center,

        child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              Text('SlamBook',
                style: TextStyle(
                  fontFamily: 'Signatra',
                  fontSize: 90,
                  color: Colors.white,
                ),
              ),

              GestureDetector(
                child: Container(
                  width: 260,
                  height: 60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/google_signin_button.png'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              )

            ]
        ),
      ),

    );

  }




  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnauthScreen();
  }
}


