import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';

// ignore: must_be_immutable
class ShippingAdBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Container(
                  width: 98.61 * SizeConfig.widthMultiplier,
                  // 355,
                  height: 16.29685 * SizeConfig.heightMultiplier,
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
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: Image.asset('asset/bikeman.png', 
                        height: 14.88 * SizeConfig.heightMultiplier, 
                        // 100
                        width: 22.2 * SizeConfig.widthMultiplier,
                        // 80.0,
                         fit:BoxFit.cover,),
                        title: Padding(
                          padding:  EdgeInsets.only(
                            left:5.56 * SizeConfig.widthMultiplier,
                            // 20.0, 
                            right: 2.22 * SizeConfig.widthMultiplier,
                            // 8.0,
                             bottom: 0.446 * SizeConfig.heightMultiplier,
                            //  3.0, 
                             top: 1.19 * SizeConfig.heightMultiplier,
                            //  8.0
                             ),
                          child: Text('Free Shipping', style: TextStyle(fontWeight: FontWeight.bold,
                           fontSize:  2.976 * SizeConfig.heightMultiplier,
                          //  20.0
                           ),),
                        ),
                        subtitle: Padding(
                          padding:  EdgeInsets.only(
                            left:5.56 * SizeConfig.widthMultiplier,
                            // 20.0, 
                            right: 2.22 * SizeConfig.widthMultiplier,
                            // 8.0,
                             bottom: 0.446 * SizeConfig.heightMultiplier,
                            //  3.0, 
                             top: 1.19 * SizeConfig.heightMultiplier,
                              ),
                          child: Text('Have you ever fully just gave in to the temptation and read your horoscope', 
                          style: TextStyle(fontSize: 
                          2.08 * SizeConfig.heightMultiplier,
                          // 14.0
                          )),
                        ),
                      )
                    ],
                  ),
                );
                
  }
}