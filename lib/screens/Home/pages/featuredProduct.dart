// import 'dart:convert';

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/products.dart';
import 'package:nuthoop/provider/cart.dart';
// import 'package:nuthoop/provider/network_status_service.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Home/pages/product_detail.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
// import 'package:nuthoop/screens/network.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../Auth/constants.dart';
import '../../../helper/config_size.dart';

class FeaturedProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductModel>>(context);
    final mes = Provider.of<ProductsProvider>(context).getMeasurement;
    Size size = MediaQuery.of(context).size;

    return (products != null)
        ? Container(
            margin: EdgeInsets.all(10.0),
            height: 27.955 * SizeConfig.heightMultiplier,
            child: (products.isEmpty)
                ? Center(
                    child: Text('No product yet, try again later'),
                  )
                : ListView.builder(
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
                                      double.parse(products[index]
                                          .prices
                                          .map((e) => e.priceRegular)
                                          .take(1)
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
                                      "${mes == products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.id).join() : "1"}")));
                        },
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            elevation: 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //  == null ? CircularProgressIndicator() :
                                ...image
                                    // .where((e) => e.unitId == 1)
                                    .map((e) {
                                  return Container(
                                    width: size.width / 2.5,
                                    height: 15 * SizeConfig.heightMultiplier,
                                    // 117,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          topRight: Radius.circular(10.0)),
                                    ),
                                    child: Image.network(
                                      "${Api.imageUrl}${e.toString()}",
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                    Color>(kBrandColor),
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                                SizedBox(height: 2),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: size.width / 2.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // SizedBox(height: size.height * 0.010),
                                        AutoSizeText('${products[index].name}',
                                            minFontSize: 10,
                                            maxFontSize: 12,
                                            maxLines: 2,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
                                                  color: kBrandColor),
                                              margin: EdgeInsets.only(
                                                  left: 1.25 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  // 10.0,
                                                  right: 1.25 *
                                                      SizeConfig
                                                          .heightMultiplier,
                                                  top: 5,
                                                  //  5.0
                                                  bottom: 5.0),
                                              child: TextButton(
                                                  onPressed: () {
                                                    // scakey.currentState.onItemTapped(2);
                                                    Provider.of<CartProvider>(
                                                            context,
                                                            listen: false)
                                                        .clear();
                                                    displayBottomSheet(
                                                        context,
                                                        products[index].name,
                                                        products[index]
                                                            .id
                                                            .toString(),
                                                        double.parse(products[
                                                                index]
                                                            .prices
                                                            .map((e) =>
                                                                e.priceRegular)
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
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))),
                                        )
                                      ],
                                    ),
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
        : Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: true,
            child: Container(
              height: MediaQuery.of(context).size.height / 6,
              margin: EdgeInsets.all(10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  6,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 80.0,
                                  height: 80.0,
                                  color: kBrandColor),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                            ],
                          ),
                        ),
                        Text('loading...')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
    // : noInternet(context);
  }
}
