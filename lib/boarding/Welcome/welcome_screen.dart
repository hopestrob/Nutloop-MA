import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';

class WelcomeScreen extends StatelessWidget {
//   logout()async{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//     var  authToken = prefs.getString('token');
//     if(authToken != null){
//        if(!mounted) return;
//      setState(() {
//         prefs.remove('token');
//      });
//     }
//     // prefs.remove('token');
// }

// @override
//   void initState() {
//    logout();
//     super.initState();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
