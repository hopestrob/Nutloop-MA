import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import '../main.dart';
import '../screens/Home/bottomNav.dart';

class AddCashPage extends StatefulWidget {
  @override
  _AddCashPageState createState() => _AddCashPageState();
}

class _AddCashPageState extends State<AddCashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoButton(
            onPressed: () {
              scakey.currentState.onItemTapped(1);
            },
            child: Text('data'),
          ),
        ],
      ),
    );
  }
}
