import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';

import '../Home/widget/header.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();
  bool _value = false;
  bool _value2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Container(child: header(context, "Add Credit Card")),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                Container(
                  width: 355,
                  height: MediaQuery.of(context).size.height / 2.291,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(bottom: 10.0, left: 5.0),
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    top: 10.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 10.0, bottom: 3.0),
                          padding: EdgeInsets.only(left: 10.0, bottom: 3.0),
                          child: Text('Enter Card Details', style: TextStyle(fontWeight: FontWeight.bold))),
                      CustomTextField(
                          controller: firstName, hitText: "Card Number"),
                      CustomTextField(
                          controller: lastName, hitText: "Name on Card"),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top:10.0, left:10.0),
                              padding: EdgeInsets.only(top:10.0, bottom: 10.0, left:10.0),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                controller: lastName,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  // hintText: hitText,
                                  fillColor: kPrimaryColor,
                                  focusColor: kPrimaryColor,
                                  contentPadding: EdgeInsets.only(bottom: 20.0),
                                  labelText: "Expiry Date",
                                  labelStyle: TextStyle(
                                      color: kPrimaryColor, fontSize: 15),
                                ),
                              )),
                              Container(
                               margin: EdgeInsets.only(top:10.0, right:5.0),
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                controller: lastName,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  // hintText: hitText,
                                  fillColor: kPrimaryColor,
                                  focusColor: kPrimaryColor,
                                  contentPadding: EdgeInsets.only(bottom: 20.0),
                                  labelText: "CVV",
                                  labelStyle: TextStyle(
                                      color: kPrimaryColor, fontSize: 15),
                                ),
                              )),
                       
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
                
                 Container(
                  width: 355,
                  height: MediaQuery.of(context).size.width / 1.8,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Container(
                          margin: EdgeInsets.only(left: 10.0, bottom: 3.0),
                          padding: EdgeInsets.only(left: 10.0, bottom: 3.0),
                          child: Text('Credit Card Options', style: TextStyle(fontWeight: FontWeight.bold),)),
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
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kBrandColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value
                              ? Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      Text('Set as default payment card')
                    ],
                  ),
                ), 
                line(context),
                    InkWell(
                  onTap: () {
                    setState(() {
                      _value2 = !_value2;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kBrandColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value2
                              ? Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      Text('Pay Once with this card')
                    ],
                  ),
                ), 
                 ],
                  ),
                ),
               
                  SizedBox(height: 20.0,),
                    Container(
                          margin: EdgeInsets.only(top:10.0, bottom: 10.0, right: 30.0, left: 30.0),
                      width: MediaQuery.of(context).size.width / 1.7,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: FlatButton(
                        onPressed: (){
                          print('Use this card');
                        },
                      child: Text('Use this Card', style: TextStyle(color: Colors.white),),
                      ),
                    ),
              
              ]),
            ))
          ]),
        ));
  }
}
line(BuildContext context)=>  Padding(padding: EdgeInsets.symmetric(horizontal: 10.0), 
                          child: Container(
                            height: 1.0,
                               width: MediaQuery.of(context).size.width,
                            color: greyColor4,
                          ),
                         );
