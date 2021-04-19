
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
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



  @override
  Widget build(BuildContext context) {
            Size size = MediaQuery.of(context).size;
        // size.height > 412 ? size.height / 12 : size.height/9
    return  Container(
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
                child: Column(
            children: [
              CustomTextField(
                controller: firstNameController,
                hitText: "First Name",
                keyboardType: TextInputType.name
              ),
            CustomTextField(
                controller: lastNameController,
                hitText: "Last Name",
                keyboardType: TextInputType.name
              ),
                CustomTextField(
                controller: txtPhone,
                hitText: "Phone Number",
                keyboardType: TextInputType.phone
              ),
                CustomEmailTextField(
                controller: emailController,
                hitText: "Email",
                keyboardType: TextInputType.emailAddress
              ),
               SizedBox(height: size.height * 0.010),
                CustomPasswordFields(
                  labeltext: "Password",
                  controller: txtPassword,
                  obscureText: Provider.of<Authentication>(context).passwordVisible,
                  suffix: InkWell(
                    child: Text(
                        Provider.of<Authentication>(context).passwordVisible ? 'SHOW' : 'HIDE'),
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
                    child: Text(
                        Provider.of<Authentication>(context).passwordVisible ? 'SHOW' : 'HIDE'),
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
                      Container(
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                          color: kBrandColor,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: registersubmitbutton(context, txtPassword.text,
                         txtConfirmPassword.text, firstNameController.text +' '+lastNameController.text, 
                         emailController.text, txtPhone.text)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           Padding(padding: EdgeInsets.symmetric(horizontal: 10.0), 
                            child: Container(
                              height: 1.0,
                              width: MediaQuery.of(context).size.width * 0.361,
                              color: greyColor5,
                            ),
                           ),
                            Text('OR', style: TextStyle(color: kBrandColor),),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 10.0), 
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
                        margin: EdgeInsets.only(top: 
                      1.66 * SizeConfig.heightMultiplier),
                       width: 83.33 * SizeConfig.widthMultiplier,
                      // height: size.height > 412 ? size.width/8 : size.width * 0.090,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: FlatButton(
                          onPressed: (){
                            Provider.of<Authentication>(context, listen: false).signUpWithFB(context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                          },
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 19.0 * SizeConfig.widthMultiplier),
                              child: Text('Connect with Facebook', style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:7.78 * SizeConfig.widthMultiplier),
                              child: Icon(FontAwesomeIcons.facebookSquare, color: Colors.white,),
                            )
                          ],
                        )
                        ),
                      ),
                       Container(
                         margin: EdgeInsets.only(top: 
                      1.66 * SizeConfig.heightMultiplier),
                       width: 83.33 * SizeConfig.widthMultiplier,
                      // height: size.height > 412 ? size.width/8 : size.width * 0.090,
                        decoration: BoxDecoration(
                          border: Border.all(color: kBrandColor),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: FlatButton(
                          onPressed: (){
                              Provider.of<Authentication>(context, listen: false).signUpWithGoogle(context);
                          },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            
                             Padding(
                                padding:  EdgeInsets.only(left: 19.4 * SizeConfig.widthMultiplier),
                                child: Text('Connect with Google', style: TextStyle(color: greyColor2),),
                              ),
                         
                            Padding(
                              padding:  EdgeInsets.only(left:7.78 * SizeConfig.widthMultiplier),
                              child: Icon(FontAwesomeIcons.google,),
                            )
                          ],
                        ),
                        ),
                      ),
                  Container(
                  margin: EdgeInsets.all(2.78 * SizeConfig.widthMultiplier),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FittedBox(child: Text("By Clicking 'Sign up' you agree to our ", style: TextStyle(fontSize: 2.78 * SizeConfig.widthMultiplier),)),
                      Text("private policy", style: TextStyle(decoration: TextDecoration.underline),),
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
    return FlatButton(
      onPressed: () async {
        if (password == passwordConfirm) {
          if (!await context.read<Authentication>().registerUser(
              name, email, password, passwordConfirm, phoneNumber)) {
            switch (context.read<Authentication>().registerError) {
              case RegisterError.invalidPassword:
                return Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text(
                        'Unable to Register, Invalid value given for password')));
              case RegisterError.emailTaken:
                return Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text(
                        'Unable to Register, Email has already been registered')));
              case RegisterError.otherErrors:
                return Scaffold.of(context).showSnackBar(new SnackBar(
                    content: Text('Error processing User registration')));
            }
          } else {
             SharedPreferences prefs = await SharedPreferences.getInstance();
              var authNames = prefs.getString('authName');
              print(authNames);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              Homepage(authName: authNames)), (Route<dynamic> route) => false);
            
          }
        } else {
          Scaffold.of(context).showSnackBar(
              new SnackBar(content: Text('Password did not match')));
        }
      },
      child: showText(context),
    );
  }
}
 