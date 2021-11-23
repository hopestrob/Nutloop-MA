import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nuthoop/boarding/Welcome/welcome_screen.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
// import 'package:nuthoop/screens/Home/bottomNav.dart';
import 'package:nuthoop/screens/Home/tab_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  final String authName;
  int selectedPage;
  Homepage({this.authName, this.selectedPage});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  void dispose() {
    read();
    super.dispose();
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

  String _currentPage = "MainProductPage";
  List<String> pageKeys = [
    "MainProductPage",
    "AllProducts",
    "CartScreen",
    "ProfileScreen"
  ];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "MainProductPage": GlobalKey<NavigatorState>(),
    "AllProducts": GlobalKey<NavigatorState>(),
    "CartScreen": GlobalKey<NavigatorState>(),
    "ProfileScreen": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "MainProductPage") {
            _selectTab("MainProductPage", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator("MainProductPage"),
            _buildOffstageNavigator("AllProducts"),
            _buildOffstageNavigator("CartScreen"),
            _buildOffstageNavigator("ProfileScreen"),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
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
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
