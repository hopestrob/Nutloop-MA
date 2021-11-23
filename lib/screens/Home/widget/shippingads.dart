import 'package:flutter/material.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/screens/Auth/constants.dart';

// ignore: must_be_immutable
class ShippingAdBar extends StatelessWidget {
  Widget widget;
  String title;
  String content;

  ShippingAdBar({this.widget, this.title, this.content});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.61 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: greyColor6,
        border: Border.all(color: greyColor4),
      ),
      margin: EdgeInsets.only(
        // bottom: 0.1976 * SizeConfig.heightMultiplier,
        left: 1.3 * SizeConfig.widthMultiplier,
        // 5.0
      ),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: 13.0, bottom: 5.0, top: 3.0, right: 10.0),
                  child: this.widget,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.0),
                      Text(
                        this.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,

                          fontSize: 2.576 * SizeConfig.heightMultiplier,
                          //  20.0
                        ),
                      ),
                      // SizedBox(height: 10.0),
                      Container(
                        width: 24.29685 * SizeConfig.heightMultiplier,
                        child: SingleChildScrollView(
                            child: Text(this.content,
                                style: TextStyle(
                                  fontSize: 1.70 * SizeConfig.heightMultiplier,
                                  // 14.0
                                ))),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
