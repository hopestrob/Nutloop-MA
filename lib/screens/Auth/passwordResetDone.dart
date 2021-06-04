import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'constants.dart';

// ignore: must_be_immutable
class ForgotPasswordDoneScreen extends StatelessWidget {

   TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      // appBar: new
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            children: [
              new Container(
                margin: EdgeInsets.only(left: 15.0, right: 5.0),
                // width: 200,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                      child: Center(
                        child: Row(
                          children: [
                              InkWell(
                                  onTap: () {
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return AuthScreen(0);
                                      },
                                    ),
                                  );
                                  },
                                child: Icon(Icons.arrow_back_ios, size: 30, color: greyColor2)),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text("Forgot Password",
                                  style: TextStyle(
                                      color: kBrandColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    
                    ),
                      line(context),
                      SizedBox(height: 30.0),
                      Text("Reset Password",
                          style: TextStyle(
                              color: kBrandColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
           SizedBox(height: 30.0),
                              Row(
                                children: [
                                    Icon(Icons.check_circle_sharp, size: 40.0, color: kBrandColor),
                                    Container(
                                      margin: EdgeInsets.all(8.0),
                                      width: MediaQuery.of(context).size.width / 1.38,
                                      child: Text('We have sent you an e-mail with instruction on how to reset your password. Check your inbox and click on the link provided', 
                                      style: TextStyle(color: greyColor3, ), textAlign: TextAlign.justify,))
                                ],
                              ),
                              

                  ]
                )
              )
            ]
          ))));


  }

  line(BuildContext context)=>  Container(
    height: 5.0,
       width: double.infinity,
    color: kBrandColor,
  );
}