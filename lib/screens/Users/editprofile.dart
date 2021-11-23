// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Auth/widget/textfield.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:provider/provider.dart';
import 'package:nuthoop/provider/auth_provider.dart';
// import 'package:nuthoop/model/user.dart';
import 'package:flutter/cupertino.dart';

import '../Home/widget/header.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Future<UserModel>  _future;

  @override
  void initState() {
    super.initState();

    // _future =  Provider.of<Authentication>(context, listen:false).getProfileDetail();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Authentication>(context, listen: false)
        .getProfileDetail(context);
    // _future =  Provider.of<Authentication>(context, listen:false).getProfileDetail();
    firstName.text = Provider.of<Authentication>(context, listen: false)
        .getSingleUserDetail
        .data
        ?.user
        ?.name;
    phone.text = Provider.of<Authentication>(context, listen: false)
        .getSingleUserDetail
        .data
        ?.user
        ?.phoneNumber;
    email.text = Provider.of<Authentication>(context, listen: false)
        .getSingleUserDetail
        .data
        ?.user
        ?.email;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Consumer<Authentication>(builder: (context, getProfile, child) {
          return Column(children: [
            Container(child: header(context, "Edit Profile")),
            SizedBox(height: 10),
            (getProfile.getSingleUserDetail.data == null)
                ? Center(child: CupertinoActivityIndicator())
                : Expanded(
                    child: Container(
                    color: greyColor5,
                    child: ListView(children: <Widget>[
                      CustomTextField(
                          controller: firstName, hitText: "Fullname"),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          readOnly: true,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          controller: email,
                          decoration: InputDecoration(
                            enabled: false,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            contentPadding: EdgeInsets.only(bottom: 20.0),
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(color: kPrimaryColor, fontSize: 15),
                            // errorText: validateName(controller.text, hitText),
                          ),
                        ),
                      ),
                      CustomTextField(
                          controller: phone, hitText: "Phone Number"),
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
                            if (phone.text.isNotEmpty) {
                              if (firstName.text.trim().isNotEmpty) {
                                if (!await context
                                    .read<Authentication>()
                                    .updateProfile(
                                        context,
                                        firstName.text.trim(),
                                        email.text.trim(),
                                        phone.text.trim())) {
                                  switch (context
                                      .read<Authentication>()
                                      .getprofileUpdateError) {
                                    case ProfileUpdateError.otherErrors:
                                      return ScaffoldMessenger.of(context)
                                          .showSnackBar(displayMessage(
                                              'Unable to Update Your Profile'));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor: kBrandColor,
                                    content:
                                        Text('Profile Successfully Updated'),
                                    duration: Duration(seconds: 3),
                                  ));
                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    displayMessage(
                                        'Name Field Must not be empty'));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  displayMessage(
                                      'Phone number Field must not be empty'));
                            }
                          },
                          child: updateProfile(context),
                        ),
                      ),
                    ]),
                  ))
          ]);
        }),
      ),
    );
  }
}
