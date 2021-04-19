import 'package:flutter/material.dart';

import 'constants.dart';
import 'passwordResetDone.dart';
import 'widget/textfield.dart';

// ignore: must_be_immutable
class ForgotPasswordScreen extends StatelessWidget {

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
                                    Navigator.of(context).pop();
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
                                    Icon(Icons.info_outline, size: 50.0, color: Colors.red,),
                                    Container(
                                      margin: EdgeInsets.all(8.0),
                                      width: MediaQuery.of(context).size.width / 1.38,
                                      child: Text('Please enter the e-mail address associated with your Nutloop acount. We will send a link to this email address to reset your password', 
                                      style: TextStyle(color: greyColor3, ), textAlign: TextAlign.justify,))
                                ],
                              ),
                               CustomTextField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                hitText: "Email",
                              ),

                              Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      color: kBrandColor,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: FlatButton(
                    onPressed: ()async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordDoneScreen()));    
                    },
                    child: Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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