import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';

// ignore: must_be_immutable
class ShippingAdBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: 80.61 * SizeConfig.widthMultiplier,
                  // 355,
                  // height: 18.29685 * SizeConfig.heightMultiplier,
                  // 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: greyColor6,
                    border: Border.all(color: greyColor4),
                  ),
                  margin: EdgeInsets.only(
                    bottom: 0.2976 * SizeConfig.heightMultiplier,
                    // 2.0, 
                    top: 0.2976 * SizeConfig.heightMultiplier, 
                    left: 1.3 * SizeConfig.widthMultiplier, 
                    // 5.0
                    ),
                  padding: EdgeInsets.only(
                    bottom: 0.2976 * SizeConfig.heightMultiplier,
                     top: 0.2976 * SizeConfig.heightMultiplier,
                     ),
                  
                  child: Column(
                    children: [                 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                        Container(
                              // padding: EdgeInsets.all(3.0),
                              child: SvgPicture.asset(
                          "asset/icons/free-delivery.svg",
                          height: 12.88 * SizeConfig.heightMultiplier,
                          fit:BoxFit.fill,
                          alignment: Alignment.center,
                          // 260
                    ),
                            ),
                      Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:5.0),
                          Text('Free Shipping',  overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,
                                 
                           fontSize:  2.576 * SizeConfig.heightMultiplier,
                          //  20.0
                           ),),
                             SizedBox(height:5.0),
                            Container(
                             width: 18.29685 * SizeConfig.heightMultiplier,
                             height: 14 * SizeConfig.heightMultiplier,
                              child: SingleChildScrollView(
                                child:Text('Have you ever fully just gave in to the temptation and read your horoscope',
                              // overflow: TextOverflow.ellipsis, 
                              // softWrap: true,
                              style: TextStyle(fontSize: 
                              1.98 * SizeConfig.heightMultiplier,
                              // 14.0
                              ))),
                            ),

                        ],
                      ),
                         
                    
                        ],
                      )
                    ],
                  ),
                );
                
  }
}