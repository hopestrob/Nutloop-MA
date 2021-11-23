import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
// import 'package:nuthoop/screens/Home/bottomNav.dart';
import 'package:nuthoop/screens/Home/pages/cart_screen.dart';
import 'package:provider/provider.dart';
import '../../../helper/config_size.dart';
// import '../homepage.dart';
// import '../mainPage.dart';

class AddToCartdisplayBottomSheet extends StatefulWidget {
  final String productName;
  final String productId;
  final double price;
  final String measurementId;
  const AddToCartdisplayBottomSheet(
      {Key key,
      this.productName,
      this.productId,
      this.price,
      this.measurementId})
      : super(key: key);

  @override
  _AddToCartdisplayBottomSheetState createState() =>
      _AddToCartdisplayBottomSheetState();
}

class _AddToCartdisplayBottomSheetState
    extends State<AddToCartdisplayBottomSheet> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<CartProvider>(context, listen: false)
          .getSavedCartItemsList(context);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Provider.of<CartProvider>(context, listen: false)
          .getSavedCartItemsList(context);
    });
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Consumer<CartProvider>(
      builder: (_, savedCartItem, child) => TextButton(
        onPressed: () async {
          if (!mounted) return;
          setState(() {
            loading = true;
          });

          // ignore: null_aware_in_condition
          if (savedCartItem?.getCartItem?.data?.items
              ?.map((e) => e.productId)
              ?.contains(int.parse(widget.productId))) {
            Provider.of<CartProvider>(context, listen: false)
                .updateCart(
                    int.parse(savedCartItem.getCartItem.data.items
                        .where(
                            (e) => e.productId == int.parse(widget.productId))
                        .map((e) => e.id)
                        .join()),
                    int.parse(savedCartItem.getCartItem.data.items
                            .where((e) =>
                                e.productId == int.parse(widget.productId))
                            .map((e) => e.quantity)
                            .join()) +
                        cart.getQuantity(),
                    savedCartItem.getCartItem.data.items
                        .where(
                            (e) => e.productId == int.parse(widget.productId))
                        .map((e) => e.productId)
                        .join())
                .then((_) {
              if (!mounted) return;
              setState(() {
                loading = false;
              });
              Provider.of<CartProvider>(context, listen: false)
                  .getSavedCartItemsList(context);
              // Navigator.pop(context);

              showModalBottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0))),
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
                                  height: 60.0,
                                ),
                                Flexible(
                                    flex: 2,
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: 'Product Added to cart',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ]),
                                    )),
                                Flexible(
                                    flex: 2,
                                    child: Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: Color(0xff80C46D),
                                      size: 120,
                                    )),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(),
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      //300
                                      width: 83.33 * SizeConfig.widthMultiplier,
                                      decoration: BoxDecoration(
                                          color: Color(0xff80C46D),
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextButton(
                                        onPressed: () async {
                                          setState(() {
                                            loading = false;
                                          });
                                          Navigator.of(context)..pop()..pop();
                                        },
                                        child: Text(
                                          'Continue Shopping',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 1.66 *
                                                SizeConfig.heightMultiplier),
                                        width:
                                            83.33 * SizeConfig.widthMultiplier,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xff80C46D)),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: TextButton(
                                          onPressed: () {
                                            SchedulerBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {
                                                loading = false;
                                              });
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CartScreen()),
                                              );
                                              // Navigator.of(context)
                                              //   ..pop()
                                              //   ..pop();
                                            });
                                          },
                                          child: Text(
                                            'Proceed to Checkout',
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
              // );
            }).catchError((_) {
              setState(() {
                loading = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kBrandColor,
                  content: Text(
                    'Product Could not add to the cart!, Try Again',
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            });
          } else {
            if (cart.getQuantity() > 0) {
              cart
                  .addCart(context, widget.productId, widget.measurementId,
                      cart.getQuantity(), widget.price)
                  .then((_) {
                setState(() {
                  loading = false;
                });
                // Navigator.pop(context);
                Provider.of<CartProvider>(context, listen: false)
                    .getSavedCartItemsList(context);
                showModalBottomSheet(
                    isDismissible: true,
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30.0))),
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
                                    height: 60.0,
                                  ),
                                  Flexible(
                                      flex: 2,
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text: 'Product Added to cart',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]),
                                      )),
                                  Flexible(
                                      flex: 2,
                                      child: Icon(
                                        Icons.check_circle_outline_outlined,
                                        color: Color(0xff80C46D),
                                        size: 120,
                                      )),
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                        //300
                                        width:
                                            83.33 * SizeConfig.widthMultiplier,
                                        decoration: BoxDecoration(
                                            color: Color(0xff80C46D),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              loading = false;
                                            });
                                            Navigator.of(context)..pop()..pop();
                                          },
                                          child: Text(
                                            'Continue Shopping',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )),
                                  Flexible(
                                      flex: 1,
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 1.66 *
                                                  SizeConfig.heightMultiplier),
                                          width: 83.33 *
                                              SizeConfig.widthMultiplier,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff80C46D)),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: TextButton(
                                            onPressed: () {
                                              SchedulerBinding.instance
                                                  .addPostFrameCallback((_) {
                                                setState(() {
                                                  loading = false;
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartScreen()),
                                                );
                                                // Navigator.of(context)
                                                //   ..pop()
                                                //   ..pop();
                                              });
                                            },
                                            child: Text(
                                              'Proceed to Checkout',
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
                // );
              }).catchError((_) {
                setState(() {
                  loading = false;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: kBrandColor,
                    content: Text(
                      'Product Could not add to the cart!, Try Again',
                    ),
                    duration: Duration(seconds: 3),
                  ),
                );
              });
            } else {
              setState(() {
                loading = false;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kBrandColor,
                  content: Text(
                    'Quantity Can not be less than 0',
                  ),
                  duration: Duration(seconds: 3),
                ),
              );
            }
          }
        },
        child: loading == true
            ? CupertinoActivityIndicator()
            : Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
      ),
    );
  }
}
