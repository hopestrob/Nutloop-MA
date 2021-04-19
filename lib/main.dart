import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'boarding/splash_screen.dart';
import 'helper/config_size.dart';
import 'provider/auth_provider.dart';
import 'provider/cart.dart';
// import 'package:flutter/services.dart';

import 'provider/products_provider.dart';

void main()async => {
  // WidgetsFlutterBinding.ensureInitialized(),
  //    await SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //   ]),
  runApp(MyApp())
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
       providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),

      ],
     child: LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
              title: 'NutLoop Ecommerce',
              home: SplashScreen(),
            );
          },
        );
      },
    )
    );
  }
}
