import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Auth/widget/textfield.dart';
import 'package:nuthoop/screens/Home/homepage.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgotpassword.dart';
import 'constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var dologin = () async {
      if (!await context
          .read<Authentication>()
          .loginUser(emailController.text, txtPassword.text)) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          switch (context.read<Authentication>().loginError) {
            case LoginError.invalidEmail:
              return ScaffoldMessenger.of(context)
                  .showSnackBar(displayMessage('Invalid credentials Entered'));
            case LoginError.invalidPassword:
              return ScaffoldMessenger.of(context)
                  .showSnackBar(displayMessage('Invalid credentials Entered'));
            case LoginError.otherErrors:
              return ScaffoldMessenger.of(context)
                  .showSnackBar(displayMessage('Unable to login'));
          }
        });
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var authNames = prefs.getString('authName');
        print(authNames);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Homepage(authName: authNames)),
            (Route<dynamic> route) => false);
      }
    };
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              hitText: "Email",
            ),
            SizedBox(height: 1.67 * SizeConfig.heightMultiplier),
            CustomPasswordFields(
              labeltext: "Password",
              controller: txtPassword,
              obscureText: Provider.of<Authentication>(context).passwordVisible,
              suffix: InkWell(
                child: Text(Provider.of<Authentication>(context).passwordVisible
                    ? 'SHOW'
                    : 'HIDE'),
                onTap: () {
                  Provider.of<Authentication>(context, listen: false).toggle();
                },
              ),
            ),
            // SizedBox(height: 20.0,),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Forgot Password?',
                      style: TextStyle(decoration: TextDecoration.underline)),
                ),
              ),
            ),
            SizedBox(height: 3.33 * SizeConfig.heightMultiplier),
            Container(
              width: 83.33 * SizeConfig.widthMultiplier,
              // 300,
              decoration: BoxDecoration(
                  color: kBrandColor, borderRadius: BorderRadius.circular(5.0)),
              child:
                  TextButton(onPressed: dologin, child: loginshowText(context)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width * 0.361,
                      color: greyColor5,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(color: kBrandColor),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width * 0.361,
                      color: greyColor5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.33 * SizeConfig.heightMultiplier),
            Container(
              margin: EdgeInsets.only(top: 1.66 * SizeConfig.heightMultiplier),
              width: 83.33 * SizeConfig.widthMultiplier,
              // height: size.height > 412 ? size.width/8 : size.width * 0.090,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                  onPressed: () async {
                    if (!await context
                        .read<Authentication>()
                        .signInFB(context)) {
                      switch (context.read<Authentication>().facebookError) {
                        case FacebookError.emailTaken:
                          return ScaffoldMessenger.of(context).showSnackBar(
                            displayMessage(
                                'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.'),
                          );
                        case FacebookError.otherErrors:
                          return ScaffoldMessenger.of(context).showSnackBar(
                              displayMessage(
                                  'Error processing User registration'));
                      }
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      var authNames = prefs.getString('authName');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Homepage(authName: authNames)),
                          (Route<dynamic> route) => false);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 19.0 * SizeConfig.widthMultiplier),
                          child: showFBSignInText(context)),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 7.78 * SizeConfig.widthMultiplier),
                        child: Icon(
                          FontAwesomeIcons.facebookSquare,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 1.66 * SizeConfig.heightMultiplier),
              // 10.0),
              width: 83.33 * SizeConfig.widthMultiplier,
              // height: size.height > 410 ? size.width/8 : size.width * 0.090,
              decoration: BoxDecoration(
                  border: Border.all(color: kBrandColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                onPressed: () {
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 19.4 * SizeConfig.widthMultiplier),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(color: greyColor2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 7.78 * SizeConfig.widthMultiplier),
                      child: Icon(
                        FontAwesomeIcons.googlePlusG,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget showFBSignInText(BuildContext context) {
  switch (context.watch<Authentication>().facebookState) {
    case FacebookState.initial:
      return Text('Connect with Facebook',
          style: TextStyle(color: Colors.white));
    case FacebookState.loading:
      return Row(children: [
        CupertinoActivityIndicator(),
        Text('Authenticating...', style: TextStyle(color: Colors.white))
      ]);
    case FacebookState.error:
      return Text('Connect with Facebook',
          style: TextStyle(color: Colors.white));
    case FacebookState.complete:
      return Text('Completed', style: TextStyle(color: Colors.white));
  }
  return Text('Connect with Facebook');
}
