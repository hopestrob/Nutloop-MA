import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/products.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Home/product_detail.dart';
import 'package:provider/provider.dart';
import '../../Auth/constants.dart';
import 'displayBottomSheet.dart';
import '../../../helper/config_size.dart';
// import 'package:shimmer/shimmer.dart';

class ListProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<ProductModel>>(context);
    final mes =
        Provider.of<ProductsProvider>(context, listen: false).getMeasurement;
    Size size = MediaQuery.of(context).size;
    // return Consumer<ProductsProvider>(builder: (context, prod, child) {
    return (products != null)
        ? Container(
            margin: EdgeInsets.all(4.866 * SizeConfig.widthMultiplier),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: SizeConfig.isPortrait ? 2 : 3,
              crossAxisSpacing: 1.0,
              childAspectRatio:
                  MediaQuery.of(context).size.aspectRatio * 2.89 / 2,
              mainAxisSpacing: 2.0,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(
                  products.length == null ? 0 : products.length, (i) {
                final x = products[i];
                var image = json.decode(x.images) as List;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                x.id.toString(),
                                "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                double.parse(Provider.of<ProductsProvider>(context, listen: false)
                                            .getMeasurement ==
                                        x.prices
                                            .where((e) =>
                                                e.unit.name.toString() ==
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .getMeasurement)
                                            .map((e) => e.unit.name)
                                            .toString()
                                            .replaceAll('(', '')
                                            .replaceAll(')', '')
                                    ? x.prices
                                        .where((e) => e.unit.name.toString() == mes)
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
                                '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}')));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    elevation: 1.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 14.8 * SizeConfig.heightMultiplier,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "${Api.imageUrl}${image.map((e) => e.toString()).join()}"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                            // 8.0
                            height: 1.0 * SizeConfig.heightMultiplier),
                        Container(
                          width: size.width / 2.5,
                          // height: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(height: size.height * 0.010),
                              Text('${x.name}',
                                  style: TextStyle(
                                      fontSize:
                                          1.88 * SizeConfig.heightMultiplier
                                      // 15.0
                                      ),
                                  overflow: TextOverflow.ellipsis),
                              Text(
                                  '#${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '') : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')}/${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                  style: TextStyle(color: Colors.grey),
                                  overflow: TextOverflow.ellipsis),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                      color: kBrandColor),
                                  margin: EdgeInsets.only(
                                    left: 1.25 * SizeConfig.heightMultiplier,
                                    right: 1.25 * SizeConfig.heightMultiplier,
                                    top: 1.25 * SizeConfig.heightMultiplier,
                                  ),
                                  //  margin: EdgeInsets.only(
                                  //                       left:
                                  //                       // 10.0,
                                  //                       right: 1.25 * SizeConfig.heightMultiplier,
                                  //                        top: 0.6268 * SizeConfig.heightMultiplier
                                  //                       //  5.0
                                  //                        ),
                                  height: 4.3876 * SizeConfig.heightMultiplier,
                                  // ,
                                  child: TextButton(
                                      onPressed: () {
                                        Provider.of<CartProvider>(context,
                                                listen: false)
                                            .clear();
                                        displayBottomSheet(
                                            context,
                                            x.name,
                                            x.id.toString(),
                                            double.parse(mes ==
                                                    x.prices
                                                        .where((e) =>
                                                            e.unit.name
                                                                .toString() ==
                                                            mes)
                                                        .map((e) => e.unit.name)
                                                        .toString()
                                                        .replaceAll('(', '')
                                                        .replaceAll(')', '')
                                                ? x.prices
                                                    .where((e) =>
                                                        e.unit.name.toString() ==
                                                        Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .getMeasurement)
                                                    .map((e) => e.priceRegular)
                                                    .toString()
                                                    .replaceAll('(', '')
                                                    .replaceAll(')', '')
                                                : x.prices
                                                    .where((e) => e.unitId == 2)
                                                    .map((e) => e.priceRegular)
                                                    .toString()
                                                    .replaceAll('(', '')
                                                    .replaceAll(')', '')),
                                            "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                            '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                            '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}');
                                        // Provider.of<ProductsProvider>(context,
                                        //         listen: false)
                                        //     .setMeasurement(
                                        //         "${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
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
                );
              }),
            ),
          )
        :
        //  Shimmer.fromColors(
        //         baseColor: Colors.grey[300],
        //         highlightColor: Colors.grey[100],
        //         enabled: true,
        //               child:
        //               Container(
        //         margin: EdgeInsets.all(4.866 * SizeConfig.widthMultiplier),
        //         child:  ),
        //   );
        Center(
            child: CupertinoActivityIndicator(
            radius: 12,
          ));
    // });
    // }});
  }
}
