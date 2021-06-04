import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/boarding/Welcome/welcome_screen.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Users/profile.dart';
import 'mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
// import 'package:nutloop_ecommerce/model/user.dart';
// import 'package:flutter/cupertino.dart'

import 'allProducts.dart';
import 'cart_screen.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  final String authName;
  int selectedPage;
  Homepage({this.authName, this.selectedPage});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //  Future<UserModel>  _future;

  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<Authentication>(context, listen: false).getProfileDetail();
    read();
    pageController = PageController();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //       if(Provider.of<Authentication>(context, listen:false).getSingleUserDetail.data?.user?.id == null){
    //         Navigator.of(context).pushReplacement(MaterialPageRoute(
    //     builder: (context) =>
    //    WelcomeScreen(),
    //   ));
    //  }
    // });
  }

  @override
  void dispose() {
    pageController.dispose();
    read();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    if (mounted) {
      setState(() {
        pageIndex = pageIndex;
      });
    }
  }

  onTap(int index) {
    // print('this is widget index page $pageIndex');
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    if (authToken == null) {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  print(Provider.of<Authentication>(context, listen:false).getSingleUserDetail.data?.user?.id);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      // appBar: new
      body:
          // FutureBuilder(
          //            future: _future,
          //                builder: (context, snapshot) {
          //                  switch (snapshot.connectionState) {
          //             case ConnectionState.waiting:
          //               return Center(
          //                 child: CupertinoActivityIndicator(
          //                       radius: 12,
          //                     ),
          //               );
          //               //  case ConnectionState.done:
          //               default:
          //               if (snapshot.hasData==null || snapshot.data == null)
          //                 return WelcomeScreen();
          //               else if(snapshot.hasError )
          //                   return WelcomeScreen();
          //               else
          //             return
          SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: PageView(
          children: <Widget>[
            MainProductPage(authName: this.widget.authName),
            AllProducts(),
            CartScreen(),
            ProfileScreen()
          ],
          controller: pageController,
          onPageChanged: (index) {
            setState(() => pageIndex = index);
          },
          // physics: NeverScrollableScrollPhysics(),
        ),
      ),
      // }}),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          // currentIndex: widget.selectedPage == null ? 0 : widget.selectedPage,
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
                icon: Icon(FontAwesomeIcons.userCircle, color: greyColor2),
                activeIcon:
                    Icon(FontAwesomeIcons.userCircle, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Profile',
                  style: TextStyle(color: greyColor2),
                )),
          ]),
    );
  }
}
