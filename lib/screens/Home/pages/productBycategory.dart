import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/model/products.dart';
// import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/pages/product_detail.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
import 'package:nuthoop/screens/Home/widget/search.dart';
import 'filter_screen.dart';

import 'package:provider/provider.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  ProductsByCategory({this.categoryName, this.categoryId});

  @override
  _ProductsByCategoryState createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Future<List<ProductModel>> _future =
        Provider.of<ProductsProvider>(context, listen: false)
            .findProductByCategory(widget.categoryId);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        // appBar: new
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(
              left: 2.4307 * SizeConfig.widthMultiplier,
              right: 1.215 * SizeConfig.widthMultiplier,
            ),
            child: Column(
              children: [
                new Container(
                  margin: EdgeInsets.only(
                    // left: 15.0, right: 5.0
                    left: 2.4307 * SizeConfig.widthMultiplier,
                    right: 1.215 * SizeConfig.widthMultiplier,
                  ),
                  // width: 200,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // margin: EdgeInsets.only(top: 3.76 * SizeConfig.heightMultiplier),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FilterScreen()));
                                    },
                                    child: Icon(Icons.filter_list)),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text('Filters'),
                              ],
                            ),
                            Expanded(
                              child: AutoSizeText(widget.categoryName,
                                  minFontSize: 10,
                                  maxFontSize: 12,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: kBrandColor,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                Text('Cheapest'),
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FilterScreen()));
                                    },
                                    child: Icon(
                                        Icons.keyboard_arrow_down_rounded)),
                                SizedBox(
                                  width: 5.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      buildSearchRow(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(children: <Widget>[
                    FutureBuilder(
                        future: _future,
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: CupertinoActivityIndicator(
                                  radius: 12,
                                ),
                              );
                            // return SizedBox();
                            default:
                              if (snapshot.hasData == null)
                                return Center(
                                    heightFactor: 2,
                                    child: Text('Try Again Later'));
                              else if (snapshot.hasError)
                                return Center(
                                    heightFactor: 2,
                                    child: Text('Try Again Later'));
                              else
                                return Consumer<ProductsProvider>(
                                    builder: (context, prod, child) {
                                  final products = prod.getProductCategory;
                                  // print('thuis is product categ $products');
                                  return Container(
                                    margin: EdgeInsets.all(10.0),
                                    // height: MediaQuery.of(context).size.height / 2.0,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) =>
                                          GridView.extent(
                                        primary: false,
                                        padding: const EdgeInsets.all(5.0),
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        maxCrossAxisExtent: 220,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        children: List.generate(
                                            products == null
                                                ? 0
                                                : products.length, (i) {
                                          final x = products[i];
                                          var image =
                                              json.decode(products[i].images)
                                                  as List;
                                          return InkWell(
                                            onTap: () {
                                              Provider.of<ProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .addItem(x.id, products);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetails(
                                                              x.id.toString(),
                                                              "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                              double.parse(x
                                                                  .prices
                                                                  .map((e) => e
                                                                      .priceRegular)
                                                                  .take(1)
                                                                  .join()),
                                                              x.name,
                                                              x.description,
                                                              x.category.name,
                                                              x.farm,
                                                              x.sku,
                                                              x.freshness,
                                                              x.deliveryDays,
                                                              x.deliveryArea,
                                                              "${x.prices.map((e) => e.unit.abbreviation).take(1).join()}",
                                                              // '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                              "${x.prices.map((e) => e.unit.id).take(1).join()}")));
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              elevation: 1.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 14.8 *
                                                          SizeConfig
                                                              .heightMultiplier,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10.0)),
                                                          image:
                                                              DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      // height: 300,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 2.0),
                                                            child: AutoSizeText(
                                                                '${x.name}',
                                                                minFontSize: 10,
                                                                maxFontSize: 12,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                          ),
                                                          ...x.prices
                                                              // .where((e) => e.unitId == 1)
                                                              .map((e) =>
                                                                  AutoSizeText(
                                                                    '₦${e.priceRegular}/${e.unit.abbreviation}',
                                                                    minFontSize:
                                                                        10,
                                                                    maxFontSize:
                                                                        12,
                                                                    maxLines: 2,
                                                                  ))
                                                              .take(1),
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            10.0)),
                                                                    color:
                                                                        kBrandColor),
                                                                margin: EdgeInsets.only(
                                                                    left: 1.25 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                    right: 1.25 *
                                                                        SizeConfig
                                                                            .heightMultiplier,
                                                                    top: 10,
                                                                    bottom: 5),
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Provider.of<CartProvider>(context, listen: false)
                                                                              .clear();
                                                                          displayBottomSheet(
                                                                              context,
                                                                              x.name,
                                                                              x.id.toString(),
                                                                              double.parse(x.prices.map((e) => e.priceRegular).take(1).join()),
                                                                              "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                              "${x.prices.map((e) => e.unit.abbreviation).take(1).join()}",
                                                                              // '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                                              "${x.prices.map((e) => e.unit.id).take(1).join()}");
                                                                        },
                                                                        child:
                                                                            AutoSizeText(
                                                                          'Add to Cart',
                                                                          minFontSize:
                                                                              10,
                                                                          maxFontSize:
                                                                              12,
                                                                          maxLines:
                                                                              2,
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ))),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                });
                          }
                        })
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
