import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:provider/provider.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import '../../screens/Home/homepage.dart';
import '../../screens/Home/allProducts.dart';
import '../../screens/Home/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Home/widget/header.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: PageView(
            children: [       
              Column(children: [
                Container(
                    child: header(context, "Edit Profile")),
                SizedBox(height: 10),
                Expanded(
                    child: Container(
                  color: greyColor5,
                  child: ListView(children: <Widget>[
                    CustomTextField(controller: firstName, hitText: "First Name"),
                    CustomTextField(controller: lastName, hitText: "Last Name"),
                    CustomTextField(controller: phone, hitText: "phone Number"),
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
                      child: FlatButton(
                        onPressed: () {
                          print("Changed");
                        },
                        child: Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ))
              ]),
        Consumer<Authentication>(
             builder: (_, authuser, child) => Homepage(authName:"${authuser.getAuthUser}", selectedPage: 0)),
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
                icon:Icon(Icons.home,
                  color: greyColor2,
                ),
                activeIcon:Icon(Icons.home,
                  color: kBrandColor,
                ),                
                // ignore: deprecated_member_use
                title: Text(
                  'Home',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_rounded, color: greyColor2),
                activeIcon:Icon(Icons.format_list_bulleted_rounded, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'All Products',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: greyColor2),
                activeIcon:Icon(Icons.shopping_cart, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Cart',
                  style: TextStyle(color: greyColor2),
                )),
            // BottomNavigationBarItem(icon: Icon(Icons.search, color: greyColor2), title: Text('Advance Search', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                       Consumer<Authentication>(
                            builder: (_, authuser, child) => Homepage(authName:"${authuser.getAuthUser}", selectedPage: 3)),), (Route<dynamic> route) => false);
                  },
                  icon: Icon(FontAwesomeIcons.userCircle, color: greyColor2)),
                activeIcon:IconButton(
                  onPressed: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                       Consumer<Authentication>(
                            builder: (_, authuser, child) => Homepage(authName:"${authuser.getAuthUser}", selectedPage: 3)),), (Route<dynamic> route) => false);
                  },
                  icon: Icon(FontAwesomeIcons.userCircle, color: kBrandColor)),
                // ignore: deprecated_member_use
                title: Text(
                  'Profile',
                  style: TextStyle(color: greyColor2),
                )),
          ]),
   
        );
  }
}
