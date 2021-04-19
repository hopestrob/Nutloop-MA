import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';

void displayBottomSheet(BuildContext context, String productName,
    String productId, double price, String imageUrl, String measurement,
     String measurementId) {
  final cart = Provider.of<Cart>(context, listen: false);
  Size size = MediaQuery.of(context).size;
  print('thsi si $measurement');
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          height: size.height > 412 ? size.height * 0.4 : size.height * 0.980,
          child: Center(
            heightFactor: 2,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.010),
                    Icon(Icons.add_shopping_cart_outlined, color: productColor, size:80.0),
                    SizedBox(height: size.height * 0.010),
                    Text("Enter The Quantity for $productName",
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    SizedBox(height: size.height * 0.020),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 38.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: kBrandColor),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Row(
                            children: [
                              Container(
                                width: 40.0,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                    color: kBrandColor.withOpacity(.3),
                                    border: Border.all(
                                        color: kBrandColor.withOpacity(.3))),
                                child: Consumer<Cart>(
                                    builder: (ctx, carts, child) => IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: kBrandColor,
                                          ),
                                          onPressed: () => carts.decrementQty(),
                                        )),
                              ),
                              Container(
                                  width: 40.0,
                                  child: Consumer<Cart>(
                                      builder: (ctx, carts, child) => Text(
                                            '${carts.getQuantity()}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ))),
                              Container(
                                // padding: EdgeInsets.only(top:5.0),
                                width: 40.0,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    color: kBrandColor.withOpacity(.3),
                                    border: Border.all(
                                        color: kBrandColor.withOpacity(.3))),
                                child: Consumer<Cart>(
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
                    SizedBox(
                      height: 20.0,
                    ),
                 
                    Consumer<Cart>(
                      builder: (ctx, total, child) => Text(
                          "You have Selecteded ${price * total.getQuantity()}/$measurement",
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(color: kBrandColor),
                      child: FlatButton(
                        onPressed: () async{ 
                          cart.addItem(productId, price, productName, imageUrl,
                          cart.getQuantity(), measurement, measurementId);
                          Navigator.pop(context);
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Product added to the cart!',
                              ),
                              duration: Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  cart.removeSingleItem(productId);
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: size.width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: kBrandColor)),
                        child: FlatButton(
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
