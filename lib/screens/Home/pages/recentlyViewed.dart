// import 'dart:convert';

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
// import 'package:nuthoop/model/products.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/pages/product_detail.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
import 'package:provider/provider.dart';
import '../../../helper/config_size.dart';
// import '../../../helper/config_size.dart';

class RecentlyViewed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsProvider>(context).items;
    final mes =
        Provider.of<ProductsProvider>(context, listen: false).getMeasurement;
    Size size = MediaQuery.of(context).size;
    return (products != null)
        ? Container(
            margin: EdgeInsets.all(10.0),
            height: 27.955 * SizeConfig.heightMultiplier,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products == null ? 0 : products.length,
              itemBuilder: (context, index) {
                var image = json.decode(products[index].images) as List;
                return InkWell(
                  onTap: () {
                    Provider.of<ProductsProvider>(context, listen: false)
                        .addItem(products[index].id, products);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                products[index].id.toString(),
                                "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                double.parse(mes ==
                                        products[index]
                                            .prices
                                            .where((e) =>
                                                e.unit.name.toString() == mes)
                                            .map((e) => e.unit.name)
                                            .join()
                                    ? products[index]
                                        .prices
                                        .where((e) =>
                                            e.unit.name.toString() == mes)
                                        .map((e) => e.priceRegular)
                                        .join()
                                    : products[index]
                                        .prices
                                        .where((e) => e.unitId == 2)
                                        .map((e) => e.priceRegular)
                                        .join()),
                                products[index].name,
                                products[index].description,
                                products[index].category.name,
                                products[index].farm,
                                products[index].sku,
                                products[index].freshness,
                                products[index].deliveryDays,
                                products[index].deliveryArea,
                                '${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join() : "kg"}',
                                "${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.id).join() : "2"}")));
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      elevation: 1.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //  == null ? CircularProgressIndicator() :
                          Container(
                            width: size.width / 2.5,
                            height: 14 * SizeConfig.heightMultiplier,
                            // 117,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                            ),
                            child: Image.network(
                              "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            kBrandColor),
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                );
                              },
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                              // 8.0
                              height: 1.0 * SizeConfig.heightMultiplier),
                          Container(
                            width: size.width / 2.5,
                            height: 11.28 * SizeConfig.heightMultiplier,
                            // 90,

                            // color: Theme.of(context).primaryColor.withOpacity(.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // SizedBox(height: size.height * 0.010),
                                Text('${products[index].name}',
                                    style: TextStyle(
                                        fontSize:
                                            1.88 * SizeConfig.heightMultiplier
                                        // 15.0
                                        ),
                                    overflow: TextOverflow.ellipsis),
                                ...products[index]
                                    .prices
                                    // .where((e) => e.unitId == 1)
                                    .map((e) => AutoSizeText(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: kBrandColor),
                                      margin: EdgeInsets.only(
                                          left: 1.25 *
                                              SizeConfig.heightMultiplier,
                                          // 10.0,
                                          right: 1.25 *
                                              SizeConfig.heightMultiplier,
                                          top: 5,
                                          //  5.0
                                          bottom: 5.0),
                                      child: TextButton(
                                          onPressed: () {
                                            // scakey.currentState.onItemTapped(2);
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .clear();
                                            displayBottomSheet(
                                                context,
                                                products[index].name,
                                                products[index].id.toString(),
                                                double.parse(products[index]
                                                    .prices
                                                    .map((e) => e.priceRegular)
                                                    .take(1)
                                                    .join()),
                                                "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                "${products[index].prices.map((e) => e.unit.abbreviation).take(1).join()}",
                                                // "${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join() : "kg"}",
                                                "${products[index].prices.map((e) => e.unit.id).take(1).join()}");
                                            // "${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.id).join() : "1"}");
                                            // prod.setMeasurement("${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join(): "kg"}");
                                          },
                                          child: AutoSizeText(
                                            'Add to Cart',
                                            minFontSize: 10,
                                            maxFontSize: 12,
                                            maxLines: 2,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            margin: EdgeInsets.all(10.0),
            height: 27.955 * SizeConfig.heightMultiplier,

            // 223, 27.955
            // 32.59 * SizeConfig.heightMultiplier
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // itemCount: 4,
              // itemBuilder: (context, index) {
              children: [
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  == null ? CircularProgressIndicator() :
                        Container(
                          width: size.width / 2.5,
                          height: 14 * SizeConfig.heightMultiplier,
                          // 117,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Image.asset(
                            "asset/images/apples.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                            // 8.0
                            height: 1.0 * SizeConfig.heightMultiplier),
                        Container(
                          width: size.width / 2.5,
                          height: 11.28 * SizeConfig.heightMultiplier,
                          // 90,

                          // color: Theme.of(context).primaryColor.withOpacity(.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: size.height * 0.010),
                              Text('Apple',
                                  style: TextStyle(
                                      fontSize:
                                          1.88 * SizeConfig.heightMultiplier
                                      // 15.0
                                      ),
                                  overflow: TextOverflow.ellipsis),
                              Text('#15.00/kg}',
                                  // Text('₦${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.priceRegular).join()}/${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join()}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: kBrandColor),
                                  margin: EdgeInsets.only(
                                      left: 1.25 * SizeConfig.heightMultiplier,
                                      // 10.0,
                                      right: 1.25 * SizeConfig.heightMultiplier,
                                      top: 0.6268 * SizeConfig.heightMultiplier
                                      //  5.0
                                      ),
                                  height: 4.3876 * SizeConfig.heightMultiplier,
                                  //  35.0,
                                  // ,
                                  child: TextButton(
                                      onPressed: () {
                                        print('waiting for data');
                                        // prod.setMeasurement("${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join(): "kg"}");
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  == null ? CircularProgressIndicator() :
                        Container(
                          width: size.width / 2.5,
                          height: 14 * SizeConfig.heightMultiplier,
                          // 117,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Image.asset(
                            "asset/images/basmati.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                            // 8.0
                            height: 1.0 * SizeConfig.heightMultiplier),
                        Container(
                          width: size.width / 2.5,
                          height: 11.28 * SizeConfig.heightMultiplier,
                          // 90,

                          // color: Theme.of(context).primaryColor.withOpacity(.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: size.height * 0.010),
                              Text('Basmatic Rice',
                                  style: TextStyle(
                                      fontSize:
                                          1.88 * SizeConfig.heightMultiplier
                                      // 15.0
                                      ),
                                  overflow: TextOverflow.ellipsis),
                              Text('#30.00/kg}',
                                  // Text('₦${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.priceRegular).join()}/${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join()}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: kBrandColor),
                                  margin: EdgeInsets.only(
                                      left: 1.25 * SizeConfig.heightMultiplier,
                                      // 10.0,
                                      right: 1.25 * SizeConfig.heightMultiplier,
                                      top: 0.6268 * SizeConfig.heightMultiplier
                                      //  5.0
                                      ),
                                  height: 4.3876 * SizeConfig.heightMultiplier,
                                  //  35.0,
                                  // ,
                                  child: TextButton(
                                      onPressed: () {
                                        print('waiting for data');
                                        // prod.setMeasurement("${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join(): "kg"}");
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  == null ? CircularProgressIndicator() :
                        Container(
                          width: size.width / 2.5,
                          height: 14 * SizeConfig.heightMultiplier,
                          // 117,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Image.asset(
                            "asset/images/Oranges.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                            // 8.0
                            height: 1.0 * SizeConfig.heightMultiplier),
                        Container(
                          width: size.width / 2.5,
                          height: 11.28 * SizeConfig.heightMultiplier,
                          // 90,

                          // color: Theme.of(context).primaryColor.withOpacity(.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: size.height * 0.010),
                              Text('Oranges',
                                  style: TextStyle(
                                      fontSize:
                                          1.88 * SizeConfig.heightMultiplier
                                      // 15.0
                                      ),
                                  overflow: TextOverflow.ellipsis),
                              Text('#125.00/kg}',
                                  // Text('₦${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.priceRegular).join()}/${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join()}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: kBrandColor),
                                  margin: EdgeInsets.only(
                                      left: 1.25 * SizeConfig.heightMultiplier,
                                      // 10.0,
                                      right: 1.25 * SizeConfig.heightMultiplier,
                                      top: 0.6268 * SizeConfig.heightMultiplier
                                      //  5.0
                                      ),
                                  height: 4.3876 * SizeConfig.heightMultiplier,
                                  //  35.0,
                                  // ,
                                  child: TextButton(
                                      onPressed: () {
                                        print('waiting for data');
                                        // prod.setMeasurement("${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join(): "kg"}");
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //  == null ? CircularProgressIndicator() :
                        Container(
                          width: size.width / 2.5,
                          height: 14 * SizeConfig.heightMultiplier,
                          // 117,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                          ),
                          child: Image.asset(
                            "asset/images/cucumber.jpg",
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                            // 8.0
                            height: 1.0 * SizeConfig.heightMultiplier),
                        Container(
                          width: size.width / 2.5,
                          height: 11.28 * SizeConfig.heightMultiplier,
                          // 90,

                          // color: Theme.of(context).primaryColor.withOpacity(.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: size.height * 0.010),
                              Text('Cucumber',
                                  style: TextStyle(
                                      fontSize:
                                          1.88 * SizeConfig.heightMultiplier
                                      // 15.0
                                      ),
                                  overflow: TextOverflow.ellipsis),
                              Text('#125.00/kg}',
                                  // Text('₦${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.priceRegular).join()}/${products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join()}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: kBrandColor),
                                  margin: EdgeInsets.only(
                                      left: 1.25 * SizeConfig.heightMultiplier,
                                      // 10.0,
                                      right: 1.25 * SizeConfig.heightMultiplier,
                                      top: 0.6268 * SizeConfig.heightMultiplier
                                      //  5.0
                                      ),
                                  height: 4.3876 * SizeConfig.heightMultiplier,
                                  //  35.0,
                                  // ,
                                  child: TextButton(
                                      onPressed: () {
                                        print('waiting for data');
                                        // prod.setMeasurement("${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).join(): "kg"}");
                                      },
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
    //  :Center(
    // child:
    // CupertinoActivityIndicator(
    //   radius: 12,
    // ));
    // }});
    // }else{return Center(
    //       child:
    //       CupertinoActivityIndicator(
    //         radius: 12,
    //       ),
    //     );
    // }
    // });
  }
}
