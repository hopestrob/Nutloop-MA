import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart.dart';

class CartItem extends StatefulWidget {
  final int id;
  final String productId;
  final String imageUrl;
  final double price;
  final int quantity;
  final String productName;
  final String measurement;
  final String measurementID;
  // final double total;

  CartItem(
    this.id,
    this.productId,
    this.imageUrl,
    this.price,
    this.quantity,
    this.productName,
    this.measurement,
    this.measurementID,
    // this.total
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (innerContext) => AlertDialog(
            title: Text('Are you sure!'),
            content: Text('Do you want to remove the cart item?'),
            actions: <Widget>[
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(innerContext).pop(false);
                },
              ),
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(innerContext).pop(true);
                },
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        // if(direction == DismissDirection.endToStart) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(widget.productId);
        // }
      },
      child: Card(
        // margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageUrl),
                          fit: BoxFit.cover)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 130.0,
                      child: Text(widget.productName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "N${(widget.price * widget.quantity)}/${widget.measurement}",
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.,
                      children: [
                        CounterView(qty: widget.quantity, id: widget.id),
                        // Container(
                        //   height: 38.0,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: kPrimaryColor.withOpacity(.3)),
                        //     borderRadius: BorderRadius.circular(10.0)
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         // padding: EdgeInsets.only(top:5.0),
                        //         width: 40.0,
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                        //           color: kPrimaryColor.withOpacity(.3),
                        //     // border: Border.all(color: kPrimaryColor.withOpacity(.3))
                        //     ),
                        //     child:  InkWell(
                        //         child: Icon(Icons.remove,  color: kPrimaryColor),
                        //         onTap: (){
                        //           if(quantity == 0) return;
                        //            Provider.of<CartProvider>(context, listen: false).decrementQty();
                        //         },
                        //     )

                        //       ),
                        //        Container(
                        //          width: 40.0,
                        //          child: Text("${Provider.of<CartProvider>(context, listen: false).getQuantity()}", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),)),
                        //      Container(
                        //         width: 40.0,
                        //         height: 50,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.only(topRight: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                        //           color: kPrimaryColor.withOpacity(.3),
                        //     // border: Border.all(color: kPrimaryColor)
                        //     ),
                        //     child: InkWell(onTap: (){
                        //       Provider.of<CartProvider>(context, listen: false).incrementQty();
                        //     },
                        //       child: Icon(Icons.add, color: kPrimaryColor),
                        //     )

                        //       ),

                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                border: Border.all(
                                    // width: 3.0,
                                    color: kPrimaryColor),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: InkWell(
                                onTap: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .deleteCart(widget.id);
                                },
                                child: Icon(FontAwesomeIcons.trash,
                                    color: Colors.white)))
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CounterView extends StatefulWidget {
  int qty;
  int id;
  CounterView({this.qty, this.id});
  @override
  _CounterViewState createState() => new _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.0,
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor.withOpacity(.3)),
          borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(top:5.0),
            width: 40.0,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0)),
              color: kPrimaryColor.withOpacity(.3),
              // border: Border.all(color: kPrimaryColor.withOpacity(.3))
            ),
            child: new IconButton(
              icon: new Icon(Icons.remove),
              onPressed: () {
                setState(() => widget.qty--);
                Provider.of<CartProvider>(context, listen: false)
                    .updateCart(widget.id, widget.qty, widget.id);
                print(widget.qty);
              }
              //  Provider.of<CartProvider>(context, listen: false).decrementQty()
              ,
            ),
          ),
          (widget.qty) <= 0
              ? Container(
                  width: 40.0,
                  child: Text(
                    widget.qty.toString(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ))
              : Container(
                  width: 40.0,
                  child: Text(
                    (widget.qty).toString(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
          Container(
              width: 40.0,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
                color: kPrimaryColor.withOpacity(.3),
                // border: Border.all(color: kPrimaryColor)
              ),
              child: new IconButton(
                  icon: new Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      widget.qty++;
                    });
                    Provider.of<CartProvider>(context, listen: false)
                        .updateCart(widget.id, widget.qty, widget.id);
                    print(widget.qty);
                  }))
        ],
      ),
    );
  }
}
