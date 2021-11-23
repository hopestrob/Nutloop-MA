import 'package:flutter/material.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Auth/widget/textfield.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
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
            Container(child: header(context, "Change Password")),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                CustomPasswordFields(
                  labeltext: "Current Password",
                  controller: password,
                  obscureText:
                      Provider.of<Authentication>(context).passwordVisible,
                  suffix: InkWell(
                    child: Provider.of<Authentication>(context).passwordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onTap: () {
                      Provider.of<Authentication>(context, listen: false)
                          .toggle();
                    },
                  ),
                ),
                CustomPasswordFields(
                  labeltext: "New Password",
                  controller: npassword,
                  obscureText:
                      Provider.of<Authentication>(context).passwordVisible,
                  suffix: InkWell(
                    child: Provider.of<Authentication>(context).passwordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onTap: () {
                      Provider.of<Authentication>(context, listen: false)
                          .toggle();
                    },
                  ),
                ),
                CustomPasswordFields(
                  labeltext: "Confirm new Password",
                  controller: cnpassword,
                  obscureText:
                      Provider.of<Authentication>(context).passwordVisible,
                  suffix: InkWell(
                    child: Provider.of<Authentication>(context).passwordVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                    onTap: () {
                      Provider.of<Authentication>(context, listen: false)
                          .toggle();
                    },
                  ),
                ),
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
                  child: TextButton(
                    onPressed: () async {
                      if (npassword.text.trim() == cnpassword.text.trim()) {
                        if (!await context
                            .read<Authentication>()
                            .changePassword(
                                password.text.trim(),
                                npassword.text.trim(),
                                cnpassword.text.trim())) {
                          switch (
                              context.read<Authentication>().getPassWordError) {
                            case PassWordError.invalidPassword:
                              return ScaffoldMessenger.of(context).showSnackBar(
                                  displayMessage('Invalid Password Entered'));
                            case PassWordError.otherErrors:
                              return ScaffoldMessenger.of(context).showSnackBar(
                                  displayMessage(
                                      'Unable to Change Your Password'));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: kBrandColor,
                            content: Text('Password Changed Successfully'),
                            duration: Duration(seconds: 3),
                          ));
                          Navigator.pop(context);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            displayMessage(
                                'New Password does not match Confirm password'));
                      }
                    },
                    child: Text(
                      'Change Password',
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
