import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        "${Provider.of<CartProvider>(context, listen: false).getTotalPrice()}",
        style: TextStyle(fontSize: 13, color: greyColor3));
  }
}
