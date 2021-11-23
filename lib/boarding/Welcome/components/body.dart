import 'package:flutter/material.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/screens/Auth/auth_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../screens/Auth/constants.dart';
import 'package:flutter_svg/svg.dart';

import 'background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //   Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;
  // ignore: unused_field
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.nuthoop.com/privacy-policy/';
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Background(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(8.3 * SizeConfig.widthMultiplier),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // * SizeConfig.heightMultiplier
                  height: 19.2 * SizeConfig.heightMultiplier,
                  // 115,
                  width: 55.6 * SizeConfig.widthMultiplier,
                  // 200,
                  child: SvgPicture.asset(
                    "asset/nuthoop-g.svg",
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
                    Text(
                      'Fresh agricultural produce at your doorsteps.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    )
                  ],
                ),
                SizedBox(height: 0.833 * SizeConfig.heightMultiplier),
                Container(
                  width: 111.11 * SizeConfig.widthMultiplier,
                  // 400,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
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
                      border: Border.all(color: kPrimaryColor)),
                  child: TextButton(
                    child: Text(
                      "Create an account",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                    onPressed: () {
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
                  margin: EdgeInsets.only(
                      left: 8.3 * SizeConfig.widthMultiplier,
                      top: 8.0,
                      bottom: 10.0),
                  child: Row(
                    children: [
                      FittedBox(
                          child: Text(
                        "By Clicking 'Sign up' you agree to our ",
                        style: TextStyle(
                            fontSize: 2.78 * SizeConfig.widthMultiplier),
                      )),
                      InkWell(
                        onTap: () => setState(() {
                          _launched = _launchInBrowser(toLaunch);
                        }),
                        child: Text(
                          "private policy",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
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
