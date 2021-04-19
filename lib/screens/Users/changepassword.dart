import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:provider/provider.dart';

import '../Home/widget/header.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController password = TextEditingController();

  TextEditingController npassword = TextEditingController();

  TextEditingController cnpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(children: [
            Container(
                child: header(context, "Change Password")),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                CustomPasswordFields(labeltext: "Current Password", obscureText: true,controller:password,),
                CustomPasswordFields(labeltext: "New Password",obscureText: true,controller:npassword ),
                CustomPasswordFields(labeltext: "Confirm New Password", obscureText: true,controller:cnpassword),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: kBrandColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: FlatButton(
                    onPressed: () async{
                      // print(password.text.trim());
                      // print(npassword.text.trim());
                      // print(cnpassword.text.trim());
                     if(npassword.text.trim() == cnpassword.text.trim()){
                        if (!await context
                              .read<Authentication>()
                              .changePassword(password.text.trim(), npassword.text.trim(), cnpassword.text.trim())) {
                            switch (context.read<Authentication>().getPassWordError) {
                              case PassWordError.invalidPassword:
                                return _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text('Invalid Password Entered')));
                              case PassWordError.otherErrors:
                                return _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('Unable to Change Your Password')));
                            }
                          } else {
                             _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('Password Changed Successfully'), duration: Duration(seconds: 3),));
                                    Navigator.pop(context);
                         
                          }
                     }else{
                         _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(content: Text('New Password does not match Confirm password')));
                     }
                    },
                    child: Text(
                      'Save Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]),
            ))
          ]),
        ));
  }
}
