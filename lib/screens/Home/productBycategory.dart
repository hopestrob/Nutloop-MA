import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/products.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/product_detail.dart';
import 'filter_screen.dart';
import 'widget/displayBottomSheet.dart';
import 'widget/search.dart';
import '../../helper/config_size.dart';
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
    //  Size size = MediaQuery.of(context).size;
    Provider.of<Authentication>(context, listen: false).setAuthUser();
    Future<List<ProductModel>> _future =
        Provider.of<ProductsProvider>(context, listen: false)
            .findProductByCategory(widget.categoryId);
    return Scaffold(
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
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                                // padding: EdgeInsets.only(top:8.0),
                                // margin: EdgeInsets.only(top: 20.0, left: 18.0),
                                child: Icon(Icons.arrow_back_ios,
                                    size: 20, color: greyColor2)),
                          ),
                          Container(
                            width: 120.0,
                            margin: EdgeInsets.only(left: 10.0),
                            child: Text(widget.categoryName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: kBrandColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
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
                                  child: GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount:
                                        SizeConfig.isPortrait ? 2 : 3,
                                    crossAxisSpacing: 1.0,
                                    childAspectRatio: MediaQuery.of(context)
                                            .size
                                            .aspectRatio *
                                        3.2 /
                                        2,
                                    mainAxisSpacing: 2.0,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: List.generate(
                                        products == null ? 0 : products.length,
                                        (i) {
                                      final x = products[i];
                                      var image = json
                                          .decode(products[i].images) as List;
                                      return x.categoryId.toString() !=
                                              this.widget.categoryId
                                          ? SizedBox()
                                          : InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ProductDetails(
                                                            x.id.toString(),
                                                            "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                            double.parse(Provider.of<ProductsProvider>(context, listen: false)
                                                                        .getMeasurement ==
                                                                    x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(
                                                                        ')', '')
                                                                ? x.prices
                                                                    .where((e) =>
                                                                        e.unit
                                                                            .name
                                                                            .toString() ==
                                                                        Provider.of<ProductsProvider>(context, listen: false).getMeasurement)
                                                                    .map((e) => e.priceRegular)
                                                                    .toString()
                                                                    .replaceAll('(', '')
                                                                    .replaceAll(')', '')
                                                                : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                5.0))),
                                                elevation: 1.0,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
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
                                                    SizedBox(
                                                        // 8.0
                                                        height: 1.0 *
                                                            SizeConfig
                                                                .heightMultiplier),
                                                    Container(
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
                                                          Text('${x.name}',
                                                              style: TextStyle(
                                                                  fontSize: 1.88 *
                                                                      SizeConfig
                                                                          .heightMultiplier),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          Text(
                                                              '#${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '') : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')}/${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              50.0)),
                                                                  color:
                                                                      kBrandColor),
                                                              margin: EdgeInsets
                                                                  .only(
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
                                                              child: TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    displayBottomSheet(
                                                                        context,
                                                                        x.name,
                                                                        x.id
                                                                            .toString(),
                                                                        double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '')
                                                                            ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')',
                                                                                '')
                                                                            : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')',
                                                                                '')),
                                                                        "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                        '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                                        '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}');
                                                                    Provider.of<ProductsProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .setMeasurement(
                                                                            "${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
                                                                  },
                                                                  child: Text(
                                                                    'Add to Cart',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
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
                              });
                        }
                      })
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
