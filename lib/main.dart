import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:nuthoop/provider/service.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import 'boarding/splash_screen.dart';
import 'helper/config_size.dart';
import 'provider/auth_provider.dart';
import 'provider/cart.dart';
// import 'package:flutter/services.dart';
import 'provider/filter_provider.dart';
import 'provider/network_status_service.dart';
import 'provider/products_provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(),
  //    await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]),
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final bestTopProduct = ProductsProvider();
    // final orderList = CartProvider(context);
    // final userDetail = Authentication(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider(context)),
          ChangeNotifierProvider(create: (_) => Authentication(context)),
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => FilterProducts()),
          ChangeNotifierProvider(create: (_) => NetworkStatusService()),
          // ChangeNotifierProxyProvider<ProductsProvider, CartProvider>(
          //   create: (context) => CartProvider(),
          //   update: (context, cartData, cart) {
          //     cart.getSavedCartItemsList(context);
          //     return cart;
          //   },
          // ),
          FutureProvider(
              create: (_) => bestTopProduct.getCategories(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),

          FutureProvider(
              create: (_) => bestTopProduct.getproductBestDeals(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),
          FutureProvider(
              create: (_) => bestTopProduct.getproductTopDeals(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),
          FutureProvider(
              create: (_) => bestTopProduct.getAllproductBestDeals(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),
          FutureProvider(
              create: (_) => bestTopProduct.getAllproductTopDeals(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),
          // FutureProvider(
          //     create: (_) => orderList.getOrdered(),
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),

          FutureProvider(
              create: (_) => bestTopProduct.getproductTopDeals(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),

          FutureProvider(
              create: (_) => bestTopProduct.getFaqies(),
              lazy: false,
              catchError: (context, error) {
                print(error.toString());
              }),
          // FutureProvider(
          //     create: (_) => userDetail.getProfileDetail(context),
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
          // FutureProvider(
          //     create: (_) => userDetail.getWalletTransaction(),
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
          // FutureProvider(
          //     create: (_) => userDetail.getAddressInOrderDetail(context),
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
          // FutureProvider(
          //     create: (_) => userDetail.getAddressBookList(context),
          //     updateShouldNotify: (_, __) => true,
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
          // FutureProvider(
          //     create: (_) => userDetail.getWallet(context),
          //     updateShouldNotify: (_, __) => true,
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),

          // StreamProvider(
          //     create: (_) => orderList.getSavedCartItemsList(),
          //     // updateShouldNotify: (_, __) => true,
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
          // FutureProvider(
          //     create: (_) => userDetail.getAddressInOrderDetail(context),
          //     updateShouldNotify: (_, __) => true,
          //     lazy: false,
          //     catchError: (context, error) {
          //       print(error.toString());
          //     }),
        ],
        child: LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                SizeConfig().init(constraints, orientation);
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      // fontFamily: 'Poppins-Regular',
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      disabledColor: kBrandColor),
                  title: 'Nuthoop',
                  color: Colors.white,
                  home: SplashScreen(),
                );
              },
            );
          },
        ));
  }
}
