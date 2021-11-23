import 'package:flutter/material.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import '../../../helper/config_size.dart';
import 'addtocartBottom.dart';

void displayBottomSheet(
    BuildContext context,
    String productName,
    String productId,
    double price,
    String imageUrl,
    String measurement,
    String measurementId) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: IntrinsicHeight(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Flexible(
                        flex: 1,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Enter The Quantity for ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text: productName,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ]),
                        )),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            //38.0
                            height: 6.33 * SizeConfig.heightMultiplier,
                            decoration: BoxDecoration(
                                border: Border.all(color: kBrandColor),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: [
                                Container(
                                  // 40.0 50.0
                                  width: 11.11 * SizeConfig.widthMultiplier,
                                  height: 6.33 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                      color: kBrandColor.withOpacity(.3),
                                      border: Border.all(
                                          color: kBrandColor.withOpacity(.3))),
                                  child: Consumer<CartProvider>(
                                      builder: (ctx, carts, child) =>
                                          IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              color: kBrandColor,
                                            ),
                                            onPressed: () =>
                                                carts.decrementQty(),
                                          )),
                                ),
                                Container(
                                    width: 11.11 * SizeConfig.widthMultiplier,
                                    child: Consumer<CartProvider>(
                                        builder: (ctx, carts, child) => Text(
                                              '${carts.getQuantity()}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 5 *
                                                      SizeConfig
                                                          .widthMultiplier,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                Container(
                                  // padding: EdgeInsets.only(top:5.0),
                                  width: 11.11 * SizeConfig.widthMultiplier,
                                  height: 6.33 * SizeConfig.heightMultiplier,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0)),
                                      color: kBrandColor.withOpacity(.3),
                                      border: Border.all(
                                          color: kBrandColor.withOpacity(.3))),
                                  child: Consumer<CartProvider>(
                                      builder: (ctx, carts, child) =>
                                          IconButton(
                                            icon: Icon(
                                              Icons.add,
                                              color: kBrandColor,
                                            ),
                                            onPressed: () =>
                                                carts.incrementQty(),
                                          )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Consumer<CartProvider>(
                          builder: (ctx, total, child) => RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'You have Selecteded:  ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                      text:
                                          "${price * total.getQuantity()}/$measurement",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ]),
                              )),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                            //300
                            width: 83.33 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                                color: Color(0xff80C46D),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: AddToCartdisplayBottomSheet(
                              productName: productName,
                              productId: productId,
                              price: price,
                              measurementId: measurementId,
                            ))),
                    Flexible(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 1.66 * SizeConfig.heightMultiplier),
                            width: 83.33 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff80C46D)),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: kBrandColor,
                                ),
                              ),
                            )))
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
