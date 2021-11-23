import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Auth/widget/textfield.dart';
import 'package:nuthoop/screens/Home/homepage.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController txtPassword = TextEditingController();

  TextEditingController txtConfirmPassword = TextEditingController();

  TextEditingController txtPhone = TextEditingController();

  TextEditingController txtRef = TextEditingController();

  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool agree = false;
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
    const String toLaunch2 = 'https://www.nuthoop.com/terms-and-conditions/';
    Size size = MediaQuery.of(context).size;
    // size.height > 412 ? size.height / 12 : size.height/9
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
                controller: firstNameController,
                hitText: "First Name",
                keyboardType: TextInputType.name),
            CustomTextField(
                controller: lastNameController,
                hitText: "Last Name",
                keyboardType: TextInputType.name),
            CustomTextField(
                controller: txtPhone,
                hitText: "Phone Number",
                keyboardType: TextInputType.phone),
            CustomEmailTextField(
                controller: emailController,
                hitText: "Email",
                keyboardType: TextInputType.emailAddress),
            SizedBox(height: size.height * 0.010),
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
            SizedBox(height: size.height * 0.010),
            CustomPasswordFields(
              labeltext: "Password",
              controller: txtConfirmPassword,
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
            SizedBox(height: size.height * 0.010),
            CustomTextField(
              controller: txtRef,
              hitText: "Referral Code",
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Material(
                  child: Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value;
                      });
                    },
                  ),
                ),
                Text(
                  'I have read and accepted the ',
                  overflow: TextOverflow.ellipsis,
                ),
                InkWell(
                  onTap: () => setState(() {
                    _launched = _launchInBrowser(toLaunch2);
                  }),
                  child: Text(
                    'terms and conditions',
                    style: TextStyle(color: kBrandColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: BoxDecoration(
                    color: kBrandColor,
                    borderRadius: BorderRadius.circular(5.0)),
                child: registersubmitbutton(
                    context,
                    txtPassword.text,
                    txtConfirmPassword.text,
                    firstNameController.text + ' ' + lastNameController.text,
                    emailController.text,
                    txtPhone.text)),
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
            SizedBox(height: size.height * 0.020),
            Container(
              margin: EdgeInsets.only(top: 1.66 * SizeConfig.heightMultiplier),
              width: 83.33 * SizeConfig.widthMultiplier,
              // height: size.height > 412 ? size.width/8 : size.width * 0.090,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                  onPressed: () async {
                    if (agree) {
                      if (!await context
                          .read<Authentication>()
                          .signUpWithFB(context)) {
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
                        print(authNames);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    Homepage(authName: authNames)),
                            (Route<dynamic> route) => false);
                      }
                    } else {
                      return ScaffoldMessenger.of(context).showSnackBar(
                          displayMessage(
                              'You must agree to our terms and conditions'));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: 19.0 * SizeConfig.widthMultiplier),
                          child: showFBSignUpText(context)),
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
              width: 83.33 * SizeConfig.widthMultiplier,
              // height: size.height > 412 ? size.width/8 : size.width * 0.090,
              decoration: BoxDecoration(
                  border: Border.all(color: kBrandColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                onPressed: () {
                  Provider.of<Authentication>(context, listen: false)
                      .signUpWithGoogle(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 19.4 * SizeConfig.widthMultiplier),
                      child: Text(
                        'Connect with Google',
                        style: TextStyle(color: greyColor2),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 7.78 * SizeConfig.widthMultiplier),
                      child: Icon(
                        FontAwesomeIcons.google,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 6.5 * SizeConfig.widthMultiplier,
                  top: 8.0,
                  bottom: 10.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                      child: Text(
                    "By Clicking 'Sign up' you agree to our ",
                    style:
                        TextStyle(fontSize: 2.78 * SizeConfig.widthMultiplier),
                  )),
                  InkWell(
                    onTap: () => setState(() {
                      _launched = _launchInBrowser(toLaunch);
                    }),
                    child: Text(
                      "private policy",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget registersubmitbutton(BuildContext context, String password,
      passwordConfirm, name, email, phoneNumber) {
    return TextButton(
      onPressed: () async {
        if (password == passwordConfirm) {
          if (!await context.read<Authentication>().registerUser(
              name, email, password, passwordConfirm, phoneNumber)) {
            switch (context.read<Authentication>().registerError) {
              case RegisterError.invalidPassword:
                return ScaffoldMessenger.of(context).showSnackBar(displayMessage(
                    'Unable to Register, Invalid value given for password'));
              case RegisterError.emailTaken:
                return ScaffoldMessenger.of(context).showSnackBar(displayMessage(
                    'Unable to Register, Email has already been registered'));
              case RegisterError.otherErrors:
                return ScaffoldMessenger.of(context).showSnackBar(
                    displayMessage('Error processing User registration'));
            }
          } else {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var authNames = prefs.getString('authName');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Homepage(authName: authNames)),
                (Route<dynamic> route) => false);
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(displayMessage('Password did not match'));
        }
      },
      child: showText(context),
    );
  }
}

Widget showFBSignUpText(BuildContext context) {
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
