import 'widget/cart_item.dart';
import 'dart:convert';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../provider/cart.dart' show CartProvider;

class CartItemBuilder extends StatelessWidget {
  const CartItemBuilder({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) {
        var image =
            json.decode(cart.getCartItem.data.items[index].product.images);
        // Provider.of<CartProvider>(context, listen: false).setTotal(
        //     int.parse(cart.getCartItem.data.items
        //         .where((e) => e.id == cart.getCartItem.data.items[index].id)
        //         .map((e) => e.quantity)
        //         .toList()
        //         .join()),
        //     double.parse(cart.getCartItem.data.items
        //         .where((e) => e.id == cart.getCartItem.data.items[index].id)
        //         .map((e) => e.product.prices
        //             .where((e) =>
        //                 e.unitId ==
        //                 cart.getCartItem.data.items[index].mUnitId)
        //             .where((e) =>
        //                 e.id == cart.getCartItem.data.items[index].priceId)
        //             .map((e) => e.priceRegular)
        //             .join())
        //         .join()));
        return CartItem(
          cart.getCartItem.data.items[index].id,
          cart.getCartItem.data.items[index].productId.toString(),
          "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
          // double.parse(cart.getCartItem.data.items[index].product.prices.where((e) => e.unitId == cart.getCartItem.data.items[index].unit.id).map((e) => e.priceRegular).join()),
          double.parse(cart.getCartItem.data.items
              .where((e) => e.id == cart.getCartItem.data.items[index].id)
              .map((e) => e.product.prices
                  .where((e) =>
                      e.unitId == cart.getCartItem.data.items[index].mUnitId)
                  .where(
                      (e) => e.id == cart.getCartItem.data.items[index].priceId)
                  .map((e) => e.priceRegular)
                  .join())
              .join()),
          cart.getCartItem.data.items[index].quantity,
          cart.getCartItem.data.items[index].product.name,
          cart.getCartItem.data.items
              .where((prod) => prod.id == cart.getCartItem.data.items[index].id)
              .map((e) => e.product.prices
                  .where((e) =>
                      e.unitId == cart.getCartItem.data.items[index].unit.id)
                  .map((e) => e.unit.abbreviation))
              .join(),
          cart.getCartItem.data.items[index].product.prices
              .where(
                  (e) => e.unitId == cart.getCartItem.data.items[index].unit.id)
              .map((e) => e.unit.abbreviation)
              .join(),
        );
        // });
      },
      itemCount: cart.getCartItem.data?.items?.length ?? 0,
    );
  }
}
