import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart.dart';

class BottomCardItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String productName;

  BottomCardItem(this.id, this.productId, this.price, this.quantity, this.productName);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
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
                FlatButton(child: Text('No'), onPressed: (){
                  Navigator.of(innerContext).pop(false);
                },),
                FlatButton(child: Text("Yes"), onPressed: (){
                  Navigator.of(innerContext).pop(true);
                },)
              ],
            ),
        );
      },
      onDismissed: (direction) {
        // if(direction == DismissDirection.endToStart) {
          Provider.of<Cart>(context, listen: false).removeItem(productId);
        // }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: FittedBox(
                child: Text("\$$price"),
              ),
            )),
            title: Text(productName),
            subtitle: Text("Total: \$${(price * quantity)}"),
            trailing: Container(
              width: 120,
              child: Row(
                children: [
                  IconButton(
                    icon:Icon(Icons.add),
                    onPressed: (){
                          Provider.of<Cart>(context, listen: false).updateProduct(productId, price, productName);
                    },
                  ),
                  Text("$quantity x"),
                  IconButton(
                        icon:Icon(Icons.remove),
                         onPressed: (){
                       Provider.of<Cart>(context, listen: false).updateProduct2(productId, price, productName);
                    },
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
