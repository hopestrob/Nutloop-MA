import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/displayBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../screens/Home/homepage.dart';
import '../../screens/Home/allProducts.dart';
import '../../screens/Home/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Home/widget/header.dart';
import 'addCard.dart';

// ignore: must_be_immutable
class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();
  PageController pageController;
  int pageIndex = 3;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    if (mounted) {
      setState(() {
        pageIndex = pageIndex;
      });
    }
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
     final cart = Provider.of<Cart>(context);
        Provider.of<Cart>(context).getSavedCartItemsList();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          children: [
            Column(
              children: [
                Column(children: [
                  Container(child: header(context, "My Orders")),
                  SizedBox(height: 10),
                  Expanded(
                      child: Container(color: greyColor5, 
                      child: 
                      Column(
                  children: [
                    SizedBox(height: size.height * 0.150),
                      Expanded(
                         flex:1,
                               child: SvgPicture.asset(
                          "asset/cart.svg",
                          height: size.width * 0.330,
                          color: kBrandColor,
                      ),
                       ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 250,
                        margin: EdgeInsets.only(top:20.0),
                        child: Text('You currently have no orders yet!', textAlign: TextAlign.center, style: TextStyle(fontSize: 24.0),)),
                    ),
                     
                      // SizedBox(height: size.height * 0.150),
                      Container(
                          margin: EdgeInsets.all(5.0 * SizeConfig.widthMultiplier),
                            width: 95 * SizeConfig.widthMultiplier,
                          padding: EdgeInsets.all(10.0),
                          // width: size.width / 1.2,
                          decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(5.0)),
                          child: FlatButton(
                        onPressed: ()async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                    var authNames = prefs.getString('authName');
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage(authName: authNames)));
                        },
                        child: Text(
                          'Continue Shopping',
                          style: TextStyle(color: Colors.white),
                        ),
                          ),
                    ),
                    SizedBox(height: size.height * 0.020),
                  ],
                )
                      ))
                ]),
              ],
            ),
            Consumer<Authentication>(
                builder: (_, authuser, child) => Homepage(
                    authName: "${authuser.getAuthUser}", selectedPage: 0)),
            AllProducts(),
            CartScreen(),
            // ProfileScreen(),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: kBrandColor,
          unselectedItemColor: greyColor2,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: greyColor2,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: kBrandColor,
                ),
                // ignore: deprecated_member_use
                title: Text(
                  'Home',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.format_list_bulleted_rounded, color: greyColor2),
                activeIcon: Icon(Icons.format_list_bulleted_rounded,
                    color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'All Products',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: greyColor2),
                activeIcon: Icon(Icons.shopping_cart, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Cart',
                  style: TextStyle(color: greyColor2),
                )),
            // BottomNavigationBarItem(icon: Icon(Icons.search, color: greyColor2), title: Text('Advance Search', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Consumer<Authentication>(
                                builder: (_, authuser, child) => Homepage(
                                    authName: "${authuser.getAuthUser}",
                                    selectedPage: 3)),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(FontAwesomeIcons.userCircle, color: greyColor2)),
                activeIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Consumer<Authentication>(
                                builder: (_, authuser, child) => Homepage(
                                    authName: "${authuser.getAuthUser}",
                                    selectedPage: 3)),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    icon:
                        Icon(FontAwesomeIcons.userCircle, color: kBrandColor)),
                // ignore: deprecated_member_use
                title: Text(
                  'Profile',
                  style: TextStyle(color: greyColor2),
                )),
          ]),
    );
  }
}
