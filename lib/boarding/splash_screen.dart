import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      read();
    });
  }

   read() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     var authToken = prefs.getString('token');  
     var authNames = prefs.getString('authName'); 
     print('auth token $authToken');
      if(authToken == null){
     Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>     
       WelcomeScreen(),
      ));
    }else{
       Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>     
       Homepage(authName: authNames),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: splashColor,
      body: Center(
        child: Container(
                height: size.height * 0.25,
                width: size.width * 0.50,
          child: SvgPicture.asset(
                  "asset/Nutlooplogo.svg",
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}
