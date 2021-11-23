import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/mainPage.dart';
import 'package:nuthoop/screens/Home/pages/allProducts.dart';
import 'package:nuthoop/screens/Home/pages/cart_screen.dart';
import 'package:nuthoop/screens/Users/profile.dart';

final scakey = new GlobalKey<_BottomState>();

class Bottom extends StatefulWidget {
  final String authName;
  Bottom({Key key, this.authName}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  final myKey = new GlobalKey<_BottomState>();
  int _selectedIndex = 0;
  final CupertinoTabController _controller = CupertinoTabController();

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.index = index;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _controller,
      key: myKey,
      tabBar: CupertinoTabBar(
        onTap: onItemTapped,
        items: const <BottomNavigationBarItem>[
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
              icon: Icon(Icons.format_list_bulleted_rounded, color: greyColor2),
              activeIcon:
                  Icon(Icons.format_list_bulleted_rounded, color: kBrandColor),
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
              activeIcon: Icon(FontAwesomeIcons.userCircle, color: kBrandColor),
              // ignore: deprecated_member_use
              title: Text(
                'Profile',
                style: TextStyle(color: greyColor2),
              )),
        ],
      ),
      // ignore: missing_return
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MainProductPage(authName: this.widget.authName),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: AllProducts(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: CartScreen(),
              );
            });
          case 3:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProfileScreen(),
              );
            });
        }
      },
    );
  }
}
