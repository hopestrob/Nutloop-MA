import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String hitText;
  final TextInputType keyboardType;
  CustomTextField({this.controller, this.hitText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.only(bottom: 20.0),
          labelText: hitText,
          labelStyle: TextStyle(color: kPrimaryColor, fontSize: 15),
          errorText: validateName(controller.text, hitText),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}

class CustomPasswordFields extends StatelessWidget {
  final String labeltext;
  final bool obscureText;
  final TextEditingController controller;
  final Widget suffix;
  const CustomPasswordFields({
    this.labeltext,
    this.obscureText,
    this.controller,
    this.suffix,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        obscureText: obscureText,
        style: TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          //  suffixIcon: icon,
          suffix: suffix,
          suffixStyle: TextStyle(
              color: kPrimaryColor, fontSize: 15, fontWeight: FontWeight.bold),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          // hintText: hitText,
          fillColor: kPrimaryColor,
          focusColor: kPrimaryColor,
          contentPadding: EdgeInsets.only(bottom: 20.0),
          labelText: labeltext,
          labelStyle: TextStyle(color: kPrimaryColor, fontSize: 15),
          errorText: validatePassword(controller.text, labeltext),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomEmailTextField extends StatelessWidget {
  TextEditingController controller;
  String hitText;
  final TextInputType keyboardType;
  CustomEmailTextField({this.controller, this.hitText, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          contentPadding: EdgeInsets.only(bottom: 20.0),
          labelText: hitText,
          labelStyle: TextStyle(color: kPrimaryColor, fontSize: 15),
          errorText: validateEmail(controller.text, hitText),
        ),
      ),
    );
  }
}

String validateEmail(String value, String hitText) {
  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value) &&
      value.isNotEmpty) {
    return "Check Your $hitText";
  }
  return null;
}

String validateName(String value, String hitText) {
  if (!(value.length > 1) && value.isNotEmpty) {
    return "$hitText should contain more than 1 characters";
  }
  return null;
}

String validatePassword(String value, String hitText) {
  if (!(value.length > 6) && value.isNotEmpty) {
    return "$hitText should contain more than 6 characters";
  }
  return null;
}

Widget showText(BuildContext context) {
  switch (context.watch<Authentication>().registerState) {
    case RegisterState.initial:
      return Text('Sign Up', style: TextStyle(color: Colors.white));
    case RegisterState.loading:
      return Row(children: [
        CupertinoActivityIndicator(),
        Text('Authenticating...', style: TextStyle(color: Colors.white))
      ]);
    case RegisterState.error:
      return Text('Try Again', style: TextStyle(color: Colors.white));
    case RegisterState.complete:
      return Text('Redirecting', style: TextStyle(color: Colors.white));
  }
  return Text('Sign Up');
}

Widget loginshowText(BuildContext context) {
  switch (context.watch<Authentication>().loginState) {
    case LoginState.initial:
      return Text('Login', style: TextStyle(color: Colors.white));
    case LoginState.loading:
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            height: 50,
            child: CupertinoActivityIndicator(
              radius: 12,
            ),
          ),
          Text("Authenticating...", style: TextStyle(color: Colors.white))
        ],
      );
    case LoginState.error:
      return Text('Login', style: TextStyle(color: Colors.white));
    case LoginState.complete:
      return Text('Redirecting', style: TextStyle(color: Colors.white));
  }
  return Text('Login', style: TextStyle(color: Colors.white));
}

Widget passwordRest(BuildContext context) {
  switch (context.watch<Authentication>().passWordResetState) {
    case PassWordResetState.initial:
      return Text('Reset', style: TextStyle(color: Colors.white));
    case PassWordResetState.loading:
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            height: 50,
            child: CupertinoActivityIndicator(
              radius: 12,
            ),
          ),
          Text("Authenticating...", style: TextStyle(color: Colors.white))
        ],
      );
    case PassWordResetState.error:
      return Text('Try Again', style: TextStyle(color: Colors.white));
    case PassWordResetState.complete:
      return Text('Reset', style: TextStyle(color: Colors.white));
  }
  return Text('Reset', style: TextStyle(color: Colors.white));
}

Widget updateProfile(BuildContext context) {
  switch (context.watch<Authentication>().profileUpdateState) {
    case ProfileUpdateState.initial:
      return Text('Save Changes', style: TextStyle(color: Colors.white));
    case ProfileUpdateState.loading:
      return Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            height: 50,
            child: CupertinoActivityIndicator(
              radius: 12,
            ),
          ),
          Text("Authenticating...", style: TextStyle(color: Colors.white))
        ],
      );
    case ProfileUpdateState.error:
      return Text('Try Again', style: TextStyle(color: Colors.white));
    case ProfileUpdateState.complete:
      return Text('Save Changes', style: TextStyle(color: Colors.white));
  }
  return Text('Save Changes', style: TextStyle(color: Colors.white));
}
