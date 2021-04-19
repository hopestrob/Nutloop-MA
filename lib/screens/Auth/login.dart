import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
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
        Size size = MediaQuery.of(context).size;
        // size.height > 410 ? size.height / 12 : size.height/9
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
                  child: Text(
                      Provider.of<Authentication>(context).passwordVisible ? 'SHOW' : 'HIDE'),
                  onTap: () {
                  Provider.of<Authentication>(context, listen: false).toggle();
                  },
                ),
              ),
                    // SizedBox(height: 20.0,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
                      },
                                          child: Padding(
                        padding: const EdgeInsets.only(right:15.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Forgot Password?',style: TextStyle(decoration: TextDecoration.underline)),
                        ),
                      ),
                    ),
                       SizedBox(height: 3.33 * SizeConfig.heightMultiplier),
                    Container(
                      width: 83.33 * SizeConfig.widthMultiplier,
                      // 300,
                      decoration: BoxDecoration(
                        color: kBrandColor,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: FlatButton(
                        onPressed: ()async{
                         if (!await context
                              .read<Authentication>()
                              .loginUser(emailController.text, txtPassword.text)) {
                            switch (context.read<Authentication>().loginError) {
                              case LoginError.invalidEmail:
                                return Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Invalid Email Entered')));
                              case LoginError.invalidPassword:
                                return Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Invalid Password Entered')));
                              case LoginError.otherErrors:
                                return Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('Unable to login')));
                            }
                          } else {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                var authNames = prefs.getString('authName');
                                print(authNames);
                               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                               Homepage(authName: authNames)), (Route<dynamic> route) => false);
                         
                          }
                        },
                        child: loginshowText(context)),
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
                    SizedBox(height: 3.33 * SizeConfig.heightMultiplier),
                    Container(
                       width: 83.33 * SizeConfig.widthMultiplier,
                      // height: size.height > 410 ? size.width/8 : size.width * 0.090,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: FlatButton(
                        onPressed: (){
                         Provider.of<Authentication>(context, listen: false).signInFB(context);
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left:
                            // 70
                            19.4 * SizeConfig.widthMultiplier),
                            child: Text('Sign in with Facebook', style: TextStyle(color: Colors.white),),
                          ),
                          Padding(
                            padding: 
                             EdgeInsets.only(left:
                             7.78 * SizeConfig.widthMultiplier
                            //  28.0
                             ),
                            child: Icon(FontAwesomeIcons.facebookSquare, color: Colors.white,),
                          )
                        ],
                      )
                      ),
                    ),
                     Container(
                      margin: EdgeInsets.only(top: 
                      1.66 * SizeConfig.heightMultiplier),
                      // 10.0),
                      width: 83.33 * SizeConfig.widthMultiplier,
                      // height: size.height > 410 ? size.width/8 : size.width * 0.090,
                      decoration: BoxDecoration(
                        border: Border.all(color: kBrandColor),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: FlatButton(
                        onPressed: (){
                               Provider.of<Authentication>(context, listen: false).signInWithGoogle(context);
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        
                        Padding(
                              padding: EdgeInsets.only(left: 19.4 * SizeConfig.widthMultiplier),
                              child: Text('Sign in with Google', style: TextStyle(color: greyColor2),),
                            ),
                        
                          Padding(
                            padding: EdgeInsets.only(left: 7.78 * SizeConfig.widthMultiplier),
                            child: Icon(FontAwesomeIcons.googlePlusG,),
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