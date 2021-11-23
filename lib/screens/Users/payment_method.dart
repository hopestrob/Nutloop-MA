import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
// import 'package:nuthoop/screens/Auth/widget/textfield.dart';

import 'addCard.dart';
import '../Home/widget/header.dart';
import '../../helper/config_size.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Container(child: header(context, "Payment Method")),
            Container(),
            Flexible(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                Container(
                  width: 355,
                  height: 41.666 * SizeConfig.heightMultiplier,
                  // 250,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 5.0),
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 8.0, bottom: 3.0, top: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Card Number',
                                    style: TextStyle(
                                        color: kBrandColor, fontSize: 15.0),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    '5399 1234 7890 2345',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ])),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 8.0,
                                bottom: 15.0,
                                top: 20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name on Card',
                                    style: TextStyle(
                                        color: kBrandColor, fontSize: 15.0),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    'Emmanuel Dafesoftware',
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ])),
                      ),
                      ListTile(
                        title: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 8.0, bottom: 3.0, top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Expiry Date',
                                        style: TextStyle(
                                            color: kBrandColor, fontSize: 15.0),
                                      ),
                                      SizedBox(height: 3.0),
                                      Text(
                                        '11/2025',
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                              color: kBrandColor,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(height: 3.0),
                                        Text(
                                          '123',
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ]),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle, color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value
                              ? Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: kBrandColor,
                                )
                              : Icon(
                                  Icons.radio_button_off_outlined,
                                  size: 30.0,
                                  color: kBrandColor,
                                ),
                        ),
                      ),
                      Text('Set as default payment card')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCardScreen()));
                  },
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.all(15.0),
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(color: kBrandColor, width: 2)),
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 3, bottom: 3),
                              child: Text(
                                'Add Another Card',
                                style: TextStyle(color: kBrandColor),
                              )))
                    ],
                  ),
                ),
              ]),
            ))
          ]),
        ));
  }
}
