import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:nuthoop/model/user.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Future<UserModel> _future;

  @override
  void initState() {
    super.initState();

    Provider.of<Authentication>(context, listen: false)
        .getProfileDetail(context);
    // _future =
    //     Provider.of<Authentication>(context, listen: false).getProfileDetail();
    Timer(Duration(milliseconds: 2000), () {
      read();
    });
  }

  read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var authNames = prefs.getString('authName');
    if (authToken == null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Homepage(authName: authNames),
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
              "asset/nuthoop-g.svg",
              color: Colors.white,
            ),
          ),
        )
        // FutureBuilder(
        //     future: Provider.of<Authentication>(context, listen: false)
        //         .getProfileDetail(context),
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.waiting:
        //           return Center(
        //             child: Container(
        //               height: size.height * 0.25,
        //               width: size.width * 0.50,
        //               child: SvgPicture.asset(
        //                 "asset/nuthoop-g.svg",
        //                 color: Colors.white,
        //               ),
        //             ),
        //           );
        //         //  case ConnectionState.done:
        //         default:
        //           if (snapshot.error == null)
        //             return WelcomeScreen();
        //           else if (snapshot.hasError)
        //             return WelcomeScreen();
        //           else
        //             return Consumer<Authentication>(
        //                 builder: (_, authuser, child) => Homepage(
        //                     authName: "${authuser.getAuthUser}",
        //                     selectedPage: 3));
        //       }
        //     })
        );
  }
}
