import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import '../../../helper/config_size.dart';

void displayBottomSheet(
    BuildContext context,
    String productName,
    String productId,
    double price,
    String imageUrl,
    String measurement,
    String measurementId) {
  final cart = Provider.of<CartProvider>(context, listen: false);
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          //380
          height: 83.33 * SizeConfig.widthMultiplier,
          child: Center(
            heightFactor: 1,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                    Icon(Icons.add_shopping_cart_outlined,
                        color: productColor,
                        //80.0
                        size: 22.22 * SizeConfig.imageSizeMultiplier),
                    SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                    Text("Enter The Quantity for $productName",
                        style: TextStyle(
                            fontSize: 4.166 * SizeConfig.widthMultiplier,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                    Row(
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
                                    builder: (ctx, carts, child) => IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: kBrandColor,
                                          ),
                                          onPressed: () => carts.decrementQty(),
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
                                                    SizeConfig.widthMultiplier,
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
                                    builder: (ctx, carts, child) => IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: kBrandColor,
                                          ),
                                          onPressed: () => carts.incrementQty(),
                                        )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                    Consumer<CartProvider>(
                      builder: (ctx, total, child) => Text(
                          "You have Selecteded ${price * total.getQuantity()}/$measurement",
                          style: TextStyle(
                              fontSize: 4.166 * SizeConfig.widthMultiplier,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                    SizedBox(height: 0.56 * SizeConfig.heightMultiplier),
                    Container(
                      //300
                      width: 83.33 * SizeConfig.widthMultiplier,
                      decoration: BoxDecoration(color: kBrandColor),
                      child: TextButton(
                        onPressed: () async {
                          // Future.delayed(Duration(milliseconds: 1), () {
                          if (cart.getQuantity() > 0) {
                            cart
                                .addCart(productId, measurementId,
                                    cart.getQuantity(), price)
                                .then((_) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Product added to the cart!',
                                  ),
                                  duration: Duration(microseconds: 1),
                                ),
                              );
                            }).catchError((_) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Product Could not add to the cart!, Try Again',
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            });
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Quantity Can not be less than 1',
                                ),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          }

                          // });
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: 1.66 * SizeConfig.heightMultiplier),
                        width: 83.33 * SizeConfig.widthMultiplier,
                        decoration: BoxDecoration(
                            border: Border.all(color: kBrandColor)),
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
                        ))
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
