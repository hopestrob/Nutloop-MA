import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/widget/timeline.dart';
import '../Home/widget/header.dart';

class ReferalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Container(child: header(context, "Refer & Earn")),
            Container(),
            Expanded(
                child: Container(
              color: greyColor5,
              child: ListView(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refer a Friend',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      Text('and you both can earn N2000'),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Timeline(
                    ///Both data needs to be provided every time. If you don't want to add detail then use single colons('')
                    children: <Widget>[
                      MapTextData(
                        mainAddress: 'Share Coupon with friends',
                        // detailAddress: ''
                      ),
                      MapTextData(
                        mainAddress: 'Friend completes the first Order',
                        // detailAddress: ''
                      ),
                      MapTextData(
                        mainAddress: 'You both earn N2,000',
                        // detailAddress: ''
                      ),
                    ],
                    indicators: <Widget>[
                      ///Add Icons here in ascending order
                      Material(
                        color: Colors.transparent,
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.green)),
                        child: Icon(
                          FontAwesomeIcons.shareAlt,
                          color: Colors.green,
                          size: 35.0,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.green)),
                        child: Icon(
                          Icons.card_giftcard,
                          color: Colors.green,
                          size: 35.0,
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        shape:
                            CircleBorder(side: BorderSide(color: Colors.green)),
                        child: Icon(
                          Icons.money,
                          color: Colors.green,
                          size: 35.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: [
                    Text('YOUR REFERRAL CODE'),
                    SizedBox(height: 10.0,),
                    DottedBorder(
                      color: Colors.green,
                      strokeWidth: 1,
                      dashPattern: [3,1],
                      child: Container(
                        width: 200,
                        height: 40,
                        child: Center(child: Text('EmmaCode120', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),))
                        ,)),
                        SizedBox(height: 10.0,),
                    Text('TAP TO COPY'),
                    SizedBox(height: 15.0,),
                    Text('or you can share on all social platforms'),
                    SizedBox(height: 15.0,),
                    Container(
                      // margin: EdgeInsets.only(left:120.0),
                      width:110,
                      height: 5 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: FlatButton(
                        onPressed: () {
                          print('Share');
                        },
                        child: Row(
                          children: [
                            Icon(Icons.share, color:Colors.white),
                            SizedBox(width: 10.0,),
                            Text(
                              'Share',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ))
          ]),
        ));
  }
}
