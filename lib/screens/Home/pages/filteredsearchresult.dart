import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/helper/config_size.dart';
// import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/pages/product_detail.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
// import 'package:nuthoop/screens/Home/widget/measurementBottom.dart';

import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchFilterResult extends StatefulWidget {
  int catId, freshness, minPrice, maxPrice, rating;
  String productName;
  SearchFilterResult(
      {this.catId,
      this.freshness,
      this.maxPrice,
      this.minPrice,
      this.rating,
      this.productName});
  @override
  _SearchFilterResultState createState() => _SearchFilterResultState();
}

class _SearchFilterResultState extends State<SearchFilterResult> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void didChangeDependencies() {
    if (!mounted) return;
    Provider.of<ProductsProvider>(context, listen: false).searchByFilter(
        widget.catId,
        widget.freshness,
        widget.minPrice,
        widget.maxPrice,
        widget.rating);
    super.didChangeDependencies();
  }

  String selectedUnit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              new Container(
                margin: EdgeInsets.only(left: 10.0, right: 5.0),
                // width: 200,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Icon(Icons.arrow_back_ios,
                                    size: 30, color: greyColor2),
                              )),
                          Container(
                            padding: EdgeInsets.only(left: 20.0),
                            width: size.width / 2.0,
                            child: Text('Search Result',
                                // textAlign: TextAlign.justify,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: kBrandColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Provider.of<ProductsProvider>(context,
                          //             listen: false)
                          //         .clearMeasurement();
                          //     measurementBottomSheet(context, selectedUnit);
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 10.0),
                          //     child: Provider.of<ProductsProvider>(context)
                          //                 .getMeasurement ==
                          //             null
                          //         ? Row(
                          //             children: [
                          //               Text('Measurement'),
                          //               Icon(Icons.keyboard_arrow_down_sharp)
                          //             ],
                          //           )
                          //         : Row(
                          //             children: [
                          //               Text(Provider.of<ProductsProvider>(
                          //                       context)
                          //                   .getMeasurement
                          //                   .toString()),
                          //               Icon(Icons.keyboard_arrow_down_sharp)
                          //             ],
                          //           ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                      final products = prod.getProductFilter;
                      return products == null
                          ? SizedBox()
                          : Container(
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
                                      products == null ? 0 : products.length,
                                      (i) {
                                    final x = products[i];
                                    var image =
                                        json.decode(products[i].images) as List;
                                    return InkWell(
                                      onTap: () {
                                        Provider.of<ProductsProvider>(context,
                                                listen: false)
                                            .addItem(x.id, products);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => ProductDetails(
                                                    x.id.toString(),
                                                    "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                    double.parse(x.prices
                                                        .map((e) =>
                                                            e.priceRegular)
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
                                                    '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                    "${x.prices.map((e) => e.unit.id).take(1).join()}")));
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
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                height: 14.8 *
                                                    SizeConfig.heightMultiplier,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0)),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                // height: 300,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.0),
                                                      child: AutoSizeText(
                                                          '${x.name}',
                                                          minFontSize: 10,
                                                          maxFontSize: 12,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    ...x.prices
                                                        // .where((e) => e.unitId == 1)
                                                        .map((e) =>
                                                            AutoSizeText(
                                                              '₦${e.priceRegular}/${e.unit.abbreviation}',
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              maxLines: 2,
                                                            ))
                                                        .take(1),
                                                    Flexible(
                                                      flex: 1,
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                                                              bottom: 10),
                                                          child: TextButton(
                                                              onPressed: () {
                                                                Provider.of<CartProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .clear();
                                                                displayBottomSheet(
                                                                    context,
                                                                    x.name,
                                                                    x.id
                                                                        .toString(),
                                                                    double.parse(x
                                                                        .prices
                                                                        .map((e) =>
                                                                            e.priceRegular)
                                                                        .take(1)
                                                                        .join()),
                                                                    "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                    // '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                                    "${x.prices.map((e) => e.unit.abbreviation).take(1).join()}",
                                                                    "${x.prices.map((e) => e.unit.id).take(1).join()}");
                                                                // Provider.of<ProductsProvider>(context, listen: false)
                                                                //     .setMeasurement("${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
                                                              },
                                                              child:
                                                                  AutoSizeText(
                                                                'Add to Cart',
                                                                minFontSize: 10,
                                                                maxFontSize: 12,
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
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
