import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/register.dart';

import 'constants.dart';
import 'login.dart';

// ignore: must_be_immutable
class AuthScreen extends StatelessWidget {
  int selectedPage;
  AuthScreen(this.selectedPage);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // size.height > 412 ? size.height / 12 : size.height/9
    print(size.height);
    return new DefaultTabController(
        initialIndex: selectedPage,
        length: 2,
        child: new Scaffold(
          backgroundColor: Colors.white,
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(
                size.height > 412 ? size.height / 12 : size.height / 9),
            child: new Container(
              width: size.width,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      indicatorColor: kPrimaryColor,
                      indicatorWeight: 1.0,
                      indicatorPadding: EdgeInsets.zero,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(),
                      labelPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      unselectedLabelColor: Colors.black,
                      unselectedLabelStyle: TextStyle(),
                      tabs: [
                        new Text("Sign in",
                            style: TextStyle(color: Colors.black)),
                        new Text("Create an account")
                      ],
                    ),
                    line(context),
                  ],
                ),
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[LoginScreen(), RegisterScreen()],
          ),
        ));
  }

  line(BuildContext context) => Container(
        height: 5.0,
        width: double.infinity,
        color: kBrandColor,
      );
}
