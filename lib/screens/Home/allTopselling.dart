import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/product_detail.dart';
import 'package:provider/provider.dart';
import 'widget/displayBottomSheet.dart';
import '../Home/widget/frontheader.dart';
import '../../helper/config_size.dart';

class AllTopSellingProductScreen extends StatefulWidget {
  @override
  _AllTopSellingProductScreenState createState() =>
      _AllTopSellingProductScreenState();
}

class _AllTopSellingProductScreenState
    extends State<AllTopSellingProductScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Authentication>(context).setAuthUser();
    Provider.of<ProductsProvider>(context, listen: false)
        .getAllproductTopDeals();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              Header(title: "All Top Selling Products"),
              Expanded(
                child: ListView(
                  children: [
                    // FutureBuilder(
                    // future: _future,
                    // builder: (context, snapshot) {
                    //   switch (snapshot.connectionState) {
                    //     case ConnectionState.waiting:
                    //       return Center(
                    //         child: CupertinoActivityIndicator(
                    //           radius: 12,
                    //         ),
                    //       );
                    //     // return SizedBox();
                    //     default:
                    //       if (snapshot.hasData==null || snapshot.data == null)
                    //         return Center(
                    //             heightFactor: 2,
                    //             child: Text('Try Again Later'));
                    //       else if (snapshot.hasError )
                    //         return Center(
                    //             heightFactor: 2,
                    //             child: Text('Try Again Later'));
                    //       else
                    //         return
                    Consumer<ProductsProvider>(builder: (context, prod, child) {
                      final products = prod.getAllProductTopSelling;
                      return products == null
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.all(
                                2.43072 * SizeConfig.widthMultiplier,
                              ),
                              // height: MediaQuery.of(context).size.height / 2.0,
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: SizeConfig.isPortrait ? 2 : 3,
                                crossAxisSpacing: 1.0,
                                childAspectRatio:
                                    MediaQuery.of(context).size.aspectRatio *
                                        3.1 /
                                        2,
                                mainAxisSpacing: 2.0,
                                physics: NeverScrollableScrollPhysics(),
                                children: List.generate(
                                    products == null ? 0 : products.length,
                                    (i) {
                                  final x = products[i];
                                  var image =
                                      json.decode(products[i].images) as List;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductDetails(
                                                  x.id.toString(),
                                                  "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                  double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '')
                                                      ? x.prices
                                                          .where((e) =>
                                                              e.unit.name.toString() ==
                                                              Provider.of<ProductsProvider>(context, listen: false)
                                                                  .getMeasurement)
                                                          .map((e) =>
                                                              e.priceRegular)
                                                          .toString()
                                                          .replaceAll('(', '')
                                                          .replaceAll(')', '')
                                                      : x.prices
                                                          .where((e) => e.unitId == 2)
                                                          .map((e) => e.priceRegular)
                                                          .toString()
                                                          .replaceAll('(', '')
                                                          .replaceAll(')', '')),
                                                  x.name,
                                                  x.description,
                                                  x.category.name,
                                                  x.farm,
                                                  x.sku,
                                                  x.freshness,
                                                  x.deliveryDays,
                                                  x.deliveryArea,
                                                  '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                  '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}')));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      elevation: 1.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 14.8 *
                                                SizeConfig.heightMultiplier,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.0),
                                                    topRight:
                                                        Radius.circular(10.0)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                          SizedBox(
                                              // 8.0
                                              height: 1.0 *
                                                  SizeConfig.heightMultiplier),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            // height: 300,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text('${x.name}',
                                                    style: TextStyle(
                                                        fontSize: 1.88 *
                                                            SizeConfig
                                                                .heightMultiplier),
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                Text(
                                                    '#${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '') : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')}/${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50.0)),
                                                        color: kBrandColor),
                                                    margin: EdgeInsets.only(
                                                      left: 1.25 *
                                                          SizeConfig
                                                              .heightMultiplier,
                                                      right: 1.25 *
                                                          SizeConfig
                                                              .heightMultiplier,
                                                      top: 1.25 *
                                                          SizeConfig
                                                              .heightMultiplier,
                                                    ),
                                                    //  margin: EdgeInsets.only(
                                                    //                       left:
                                                    //                       // 10.0,
                                                    //                       right: 1.25 * SizeConfig.heightMultiplier,
                                                    //                        top: 0.6268 * SizeConfig.heightMultiplier
                                                    //                       //  5.0
                                                    //                        ),
                                                    height: 4.3876 *
                                                        SizeConfig
                                                            .heightMultiplier,
                                                    // ,
                                                    // ,
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Provider.of<CartProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .clear();
                                                          displayBottomSheet(
                                                            context,
                                                            x.name,
                                                            x.id.toString(),
                                                            double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '')
                                                                ? x.prices
                                                                    .where((e) =>
                                                                        e.unit.name.toString() ==
                                                                        Provider.of<ProductsProvider>(context, listen: false)
                                                                            .getMeasurement)
                                                                    .map((e) => e
                                                                        .priceRegular)
                                                                    .toString()
                                                                    .replaceAll(
                                                                        '(', '')
                                                                    .replaceAll(
                                                                        ')', '')
                                                                : x.prices
                                                                    .where((e) => e.unitId == 2)
                                                                    .map((e) => e.priceRegular)
                                                                    .toString()
                                                                    .replaceAll('(', '')
                                                                    .replaceAll(')', '')),
                                                            "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                            '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                            '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}',
                                                          );
                                                          // Provider.of<ProductsProvider>(context, listen: false)
                                                          //     .setMeasurement("${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
                                                        },
                                                        child: Text(
                                                          'Add to Cart',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                    })
                    //   }
                    // }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
