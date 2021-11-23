import 'package:flutter/material.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Home/mainPage.dart';
import 'package:nuthoop/screens/Home/pages/allProducts.dart';
import 'package:nuthoop/screens/Users/profile.dart';
import 'package:provider/provider.dart';

import 'pages/cart_screen.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "MainProductPage")
      child = Consumer<Authentication>(
          builder: (_, authuser, child) =>
              MainProductPage(authName: "${authuser.getAuthUser}"));
    else if (tabItem == "AllProducts")
      child = AllProducts();
    else if (tabItem == "CartScreen")
      child = CartScreen();
    else if (tabItem == "ProfileScreen") child = ProfileScreen();
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
