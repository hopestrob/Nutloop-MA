import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nuthoop/boarding/Welcome/welcome_screen.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
// import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Users/editprofile.dart';
// import 'package:nuthoop/screens/Users/rewardcard.dart';
import 'package:nuthoop/screens/Users/wallet.dart';
import 'package:provider/provider.dart';
import 'changepassword.dart';
import 'customer_service.dart';
import 'faqScreen.dart';
// import 'order_screen.dart';
import 'help.dart';
import 'orderedpageSub.dart';
import 'orders_details_screen.dart';
// import 'payment_method.dart';
import 'referralPage.dart';
import 'saved_page.dart';
// import 'widget/actionRow.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<Authentication>(context, listen: false).setAuthUser();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Column(
              children: [
                SizedBox(height: 20),
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
                              "${authuser.getSingleUserDetail?.data?.user?.name == null ? authuser.getAuthUser : authuser.getSingleUserDetail?.data?.user?.name}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: greyColor3,
                              )),
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersDetailsScreen()));
                    //  ordersDetails.length == 0 ? Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen())) :Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersDetailsScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/orders.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "My Orders"),
                ),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersDetailsSubScreen()));
                    //  ordersDetails.length == 0 ? Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderScreen())) :Navigator.push(context, MaterialPageRoute(builder: (context)=>OrdersDetailsScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/orders.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "My Orders Sub"),
                ),
                line(context),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/Profile.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "Edit Profile"),
                ),
                // line(context),
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => PaymentMethodScreen()));
                //     },
                //     child: makeListTile(
                //         FontAwesomeIcons.moneyCheck, "Payment Method")),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SavedProductScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/saved.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "Saved"),
                ),
                line(context),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReferalScreen()));
                    },
                    child: makeListTile(
                        SvgPicture.asset(
                          "asset/images/refer.svg",
                          height: 20,
                          color: kBrandColor,
                        ),
                        "Refer a Friend")),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WalletScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/wallet.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "Wallet"),
                ),
                line(context),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => RewardCardpage()));
                //   },
                //   child: makeListTile(
                //       SvgPicture.asset(
                //         "asset/images/rewardcard.svg",
                //         height: 20,
                //         color: kBrandColor,
                //       ),
                //       "Reward Cards"),
                // ),
                // line(context),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => NotificationScreen()));
                //   },
                //   child: makeListTile(
                //       SvgPicture.asset(
                //         "asset/images/notification.svg",
                //         height: 20,
                //         color: kBrandColor,
                //       ),
                //       "Notifications"),
                // ),
                // line(context),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen()));
                    },
                    child: makeListTile(
                        SvgPicture.asset(
                          "asset/images/changepw.svg",
                          height: 20,
                          color: kBrandColor,
                        ),
                        "Change Password")),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerService()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/customer.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "Customer Service"),
                ),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FaqScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/faq.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "FAQs"),
                ),
                line(context),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpScreen()));
                  },
                  child: makeListTile(
                      SvgPicture.asset(
                        "asset/images/faq.svg",
                        height: 20,
                        color: kBrandColor,
                      ),
                      "Help"),
                ),
                line(context),
                InkWell(
                    onTap: () {
                      final GoogleSignIn googleSignIn = GoogleSignIn();
                      googleSignIn.signOut();
                      Provider.of<Authentication>(context, listen: false)
                          .logout()
                          .then((value) => {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .logout2()
                                    .then((value) => {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WelcomeScreen()),
                                                  (Route<dynamic> route) =>
                                                      false)
                                        })
                              });
                    },
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        // decoration: new BoxDecoration(
                        //     border: new Border(
                        //         right: new BorderSide(
                        //             width: 1.0, color: Colors.black87))),
                        child: SvgPicture.asset(
                          "asset/images/logout.svg",
                          height: 20,
                          color: kBrandColor,
                        ),
                      ),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ))
              ]),
            ))
          ]),
        ));
  }
}

line(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.35,
        color: greyColor4,
      ),
    );
makeListTile(Widget icon, String title) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      // decoration: new BoxDecoration(
      //     border: new Border(
      //         right: new BorderSide(
      //             width: 1.0, color: Colors.black87))),
      child: icon,
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
    ),
    trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.black54, size: 30.0));
