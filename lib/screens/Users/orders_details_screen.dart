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
class OrdersDetailsScreen extends StatefulWidget {
  @override
  _OrdersDetailsScreenState createState() => _OrdersDetailsScreenState();
}

class _OrdersDetailsScreenState extends State<OrdersDetailsScreen> with SingleTickerProviderStateMixin {

  PageController pageController;
  int pageIndex = 3;

  TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener((){
      if (!_tabController.indexIsChanging){
        setState(() {
          _selectedTab = _tabController.index; 
        });
      }
    });
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
                     DefaultTabController(
          length: 3,
          child: Column(
            children: <Widget>[
              Material(
                color: Colors.grey.shade300,
                child: TabBar(
                  unselectedLabelColor: Colors.blue,
                  labelColor: Colors.blue,
                  indicatorColor: Colors.white,
                  controller: _tabController,
                  labelPadding: const EdgeInsets.all(0.0),
                  tabs: [
                    _getTab(0, Text('All')),
                    _getTab(1, Text('Open Orders')),
                    _getTab(2, Text('Closed Orders')),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    Icon(Icons.directions_car),
                    Icon(Icons.directions_transit),
                    Icon(Icons.directions_bike),
                  ],
                ),
              ),
            ],
          )),
                     
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
   _getTab(index, child) {
    return Tab(
      child: SizedBox.expand(
        child: Container(
          child: child,
          decoration: BoxDecoration(
              color:
                  (_selectedTab == index ? Colors.white : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index)),
        ),
      ),
    );
  }

  _generateBorderRadius(index) {
    if ((index + 1) == _selectedTab)
      return BorderRadius.only(bottomRight: Radius.circular(10.0));
    else if ((index - 1) == _selectedTab)
      return BorderRadius.only(bottomLeft: Radius.circular(10.0));
    else
      return BorderRadius.zero;
  }
}
