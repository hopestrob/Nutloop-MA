import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/screens/Auth/auth_screen.dart';
import '../../../screens/Auth/constants.dart';
import 'package:flutter_svg/svg.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
          child: Background(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.3 *  SizeConfig.widthMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // * SizeConfig.heightMultiplier
                  height: 19.2 * SizeConfig.heightMultiplier,
                  // 115,
                  width: 55.6 *  SizeConfig.widthMultiplier,
                  // 200,
                    child: SvgPicture.asset(
                            "asset/Nutlooplogo.svg",
                          ),
                  ),
                Column(
                  children: [
                    SvgPicture.asset(
                      "asset/bikeman.svg",
                      height: 43.3 * SizeConfig.heightMultiplier,
                      // 260
                    ),
                  SizedBox(height: 5.0),
                    Text('Fresh agricultural produce at your doorsteps.', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),)
                  ],
                ),
                SizedBox(height: 0.833 * SizeConfig.heightMultiplier),
                Container(
                  width: 111.11 *SizeConfig.widthMultiplier,
                  // 400,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: FlatButton(
                    child:Text("Sign in", style: TextStyle(color: Colors.white),),
                   onPressed: (){
                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AuthScreen(0);
                          },
                        ),
                      );
                   },
                  ),
                ),
                SizedBox(height: 1.67 * SizeConfig.heightMultiplier),
                Container(
                   width: 111.11 * SizeConfig.widthMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: kPrimaryColor)
                  ),
                  child: FlatButton(
                    child:Text("Create an account", style: TextStyle(color: kPrimaryColor),),
                   onPressed: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AuthScreen(1);
                        },
                      ),
                    );
                   },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2.78 * SizeConfig.widthMultiplier),
                  child: Row(
                    children: [
                      FittedBox(child: Text("By Clicking 'Sign up' you agree to our ", style: TextStyle(fontSize: 2.78 * SizeConfig.widthMultiplier),)),
                      Text("private policy", style: TextStyle(decoration: TextDecoration.underline),),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
