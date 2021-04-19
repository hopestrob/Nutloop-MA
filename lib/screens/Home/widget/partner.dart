import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';

// ignore: must_be_immutable
class PartnerBar extends StatelessWidget {
  Color color;
  PartnerBar({this.color});
  @override
  Widget build(BuildContext context) {
    return  Container(
                  width: 44.50 * SizeConfig.heightMultiplier,
                  // 355,
                  height: 16.29685 * SizeConfig.heightMultiplier,
                  // 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  margin: EdgeInsets.only(
                    bottom:  0.1 * SizeConfig.heightMultiplier,
                    top:  1.25 * SizeConfig.heightMultiplier,
                    left: 0.6268 * SizeConfig.heightMultiplier),
                  padding: EdgeInsets.only(
                    bottom: 0.1 * SizeConfig.heightMultiplier,
                     top: 1.25 * SizeConfig.heightMultiplier,),
                  
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Padding(
                          padding:  EdgeInsets.only(
                          left:2.5072 * SizeConfig.heightMultiplier,
                          // 20.0, 
                          right: 1.0 * SizeConfig.heightMultiplier,
                           bottom:0.25 * SizeConfig.heightMultiplier,
                            top: 1.0 * SizeConfig.heightMultiplier,),
                          child: Text('Ordering Sales Partner', style: TextStyle(fontWeight: FontWeight.bold, 
                          fontSize: 2.5072 * SizeConfig.heightMultiplier,),),
                        ),
                        subtitle: Padding(
                          padding:  EdgeInsets.only(
                            left:2.5072 * SizeConfig.heightMultiplier, 
                            right: 1.0 * SizeConfig.heightMultiplier,
                             bottom: 0.1 * SizeConfig.heightMultiplier,
                            //  3.0, 
                             top: 1.0 * SizeConfig.heightMultiplier),
                          child: Text('Register now to become a NutLoop Ordering Sales Partner and enjoy high commission, Bonuses, support, training etc', 
                          style: TextStyle(color: Colors.white, fontSize:
                          1.755 * SizeConfig.heightMultiplier,
                          //  14.0
                           )),
                        ),
                      )
                    ],
                  ),
                );
                
  }
}