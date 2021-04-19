import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
// import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:nutloop_ecommerce/screens/Users/addCard.dart';

import '../Home/widget/header.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();

   bool _value1 = false;
 bool _value2 = false;
 bool _value3 = false;
 bool _value4 = false;

 void _onChanged1(bool value) => setState(() => _value1 = value);
 void _onChanged2(bool value) => setState(() => _value2 = value);
 void _onChanged3(bool value) => setState(() => _value3 = value);
 void _onChanged4(bool value) => setState(() => _value4 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Container(
                child: header(context, "Notifications")),
            SizedBox(height: 10),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
             Container(
        padding: new EdgeInsets.only(top:32.0, bottom: 30.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: new SwitchListTile(
                    value: _value2,
                    onChanged: _onChanged2,
                    inactiveThumbColor: Colors.white,
                    activeColor: kBrandColor,
                    title: new Text('Order Tracking', style: new TextStyle(fontSize: 20.0, color: greyColor2)),
                    subtitle: Text('Notify me on my Order status'),
                ),
              ),
                 Padding(
                   padding: const EdgeInsets.only(bottom:20.0),
                   child: new SwitchListTile(
                    value: _value1,
                    onChanged: _onChanged1,
                    inactiveThumbColor: Colors.white,
                    activeColor: kBrandColor,
                    title: new Text('Discount & Sales', style: new TextStyle(fontSize: 20.0, color: greyColor2)),
                    subtitle: Text('Notify me on promo and Best Sales'),
              ),
                 ),
              line(context),
                Padding(
                  padding: const EdgeInsets.only(bottom:20.0, top: 10.0),
                  child: new SwitchListTile(
                    value: _value3,
                    onChanged: _onChanged3,
                    inactiveThumbColor: Colors.white,
                    activeColor: kBrandColor,
                    title: new Text('Stocks Notifications', style: new TextStyle(fontSize: 20.0, color: greyColor2)),
                    subtitle: Text('Notify me on when am out of stock product in book'),
              ),
                ),
              line(context),
               Padding(
                 padding: const EdgeInsets.only(top:10.0),
                 child: new SwitchListTile(
                    value: _value4,
                    onChanged: _onChanged4,
                    inactiveThumbColor: Colors.white,
                    activeColor: kBrandColor,
                    // contentPadding:EdgeInsets.all(30.0),
                    title: new Text('Stocks Notifications', style: new TextStyle(fontSize: 20.0, color: greyColor2)),
                    subtitle: Text('Notify me on when am out of stock product in book'),
              ),
               ),
            ],
          ),
        ))
            ]),
            ))
          ]),
        ));
  }
}
