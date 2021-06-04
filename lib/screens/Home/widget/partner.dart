import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';

// ignore: must_be_immutable
class PartnerBar extends StatelessWidget {
  Color color;
  PartnerBar({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
                  width: 65.61 * SizeConfig.widthMultiplier,
                  // 355,
                  // height: 18.29685 * SizeConfig.heightMultiplier,
                  // 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: color,
                  ),
                  margin: EdgeInsets.only(
                    bottom: 0.2976 * SizeConfig.heightMultiplier,
                    // 2.0, 
                    top: 0.2976 * SizeConfig.heightMultiplier, 
                    left: 1.3 * SizeConfig.widthMultiplier, 
                    // 5.0
                    ),
                  padding: EdgeInsets.only(
                    bottom: 0.2 * SizeConfig.heightMultiplier,
                     top: 1.0 * SizeConfig.heightMultiplier,
                     left: 30.0,
                     ),
                  
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                 
                      SizedBox(height:5.0),
                      Text('Ordering Sales Partner',  overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,
                             
                       fontSize:  2.576 * SizeConfig.heightMultiplier,
                      //  20.0
                       ),),
                         SizedBox(height:5.0),
                        Container(
                         width: 35.29685 * SizeConfig.heightMultiplier,
                         height: 14 * SizeConfig.heightMultiplier,
                          child: SingleChildScrollView(
                            child:Text('Register now to become a NutLoop Ordering Sales Partner and enjoy high commission, Bonuses, support, training etc',
                          // overflow: TextOverflow.ellipsis, 
                          // softWrap: true,
                          style: TextStyle(fontSize: 
                          2.23 * SizeConfig.heightMultiplier,
                          color: Colors.white
                          // 14.0
                          ))),
                        )
                    ],
                  ),
                );
                    
  }
}