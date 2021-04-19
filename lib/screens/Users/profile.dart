import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutloop_ecommerce/boarding/Welcome/welcome_screen.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Users/editprofile.dart';
import 'package:provider/provider.dart';
import 'changepassword.dart';
import 'customer_service.dart';
import 'faqScreen.dart';
import 'notifications.dart';
import 'order_screen.dart';
import 'orders_details_screen.dart';
import 'payment_method.dart';
import 'referralPage.dart';
import 'saved_page.dart';
// import 'widget/actionRow.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Authentication>(context).setAuthUser();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Column(
              children: [
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => {print('Hello')},
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: productColor2,
                          child: Icon(
                            Icons.person,
                            size: 50.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<Authentication>(
                            builder: (_, authuser, child) => Text(
                                "${authuser.getAuthUser}",
                                 style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: greyColor3,)),
                          ), 
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Expanded(
                child: Container(
              color: greyColor7,
              child: ListView(children: <Widget>[
                 InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersDetailsScreen()));
                  },
             child:  makeListTile(FontAwesomeIcons.shoppingBag, "My Orders"),
                 ),
                line(context),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
                  },
                  child: makeListTile(FontAwesomeIcons.userEdit, "Edit Profile"),
                  ),
              
                line(context),
               InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodScreen()));
                  },
                 child:makeListTile(FontAwesomeIcons.moneyCheck, "Payment Method")),
                line(context),

                
                InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SavedProductScreen()));
                  },
                  child:makeListTile(FontAwesomeIcons.save, "Saved"),
                ),

               line(context),
                 InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReferalScreen()));
                  },
                 child:makeListTile(FontAwesomeIcons.userAstronaut, "Refer a Friend")),

               line(context),
               makeListTile(FontAwesomeIcons.moneyBill, "Wallet"),

               line(context),
               makeListTile(FontAwesomeIcons.idCard, "Reward Card"),


                line(context),
             
                InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                  },
                 child:  makeListTile(Icons.notifications,"Notifications"),),
                line(context),
                 InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePasswordScreen()));
                  },
                 child:  makeListTile(Icons.lock, "Change Password")),
               
                line(context),
                
                InkWell(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerService()));
                  },
                  child:makeListTile(Icons.headset, "Customer Service"),
                ),
                line(context),
               InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqScreen()));
                  },
                  child:makeListTile(Icons.question_answer ,"FAQ"),
               ),
                line(context),
                 InkWell(
                  onTap: (){
                    Provider.of<Authentication>(context, listen: false).logout();
                     final GoogleSignIn googleSignIn = GoogleSignIn();
                     googleSignIn.signOut();
                                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              WelcomeScreen()), (Route<dynamic> route) => false);
                  },
                  child:  makeListTile(Icons.lock_open,"Logout"),
                )

              

              ]), 
            ))
          ]),
        ));
  }
}

line(BuildContext context)=>  Padding(padding: EdgeInsets.symmetric(horizontal: 10.0), 
                          child: Container(
                            height: 1.0,
                               width: MediaQuery.of(context).size.width * 0.35,
                            color: greyColor4,
                          ),
                         );
   makeListTile(IconData icon, String title) => ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      // decoration: new BoxDecoration(
                      //     border: new Border(
                      //         right: new BorderSide(
                      //             width: 1.0, color: Colors.black87))),
                      child: Icon(icon, color: kBrandColor),
                    ),
                    title: Text(
                      title,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black54, size: 30.0));