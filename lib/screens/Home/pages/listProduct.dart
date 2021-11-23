import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/products.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Home/pages/product_detail.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../Auth/constants.dart';
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
        ? (products.isEmpty)
            ? Center(
                child: Text('No product yet, try again later'),
              )
            : LayoutBuilder(
                builder: (context, constraints) => GridView.extent(
                  primary: false,
                  padding: const EdgeInsets.all(1.0),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  maxCrossAxisExtent: 250,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(
                      products.length == null ? 0 : products.length, (i) {
                    final x = products[i];
                    var image = json.decode(x.images) as List;
                    return InkWell(
                      onTap: () {
                        Provider.of<ProductsProvider>(context, listen: false)
                            .addItem(x.id, products);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    x.id.toString(),
                                    "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                    double.parse(x.prices
                                        .map((e) => e.priceRegular)
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
                                    '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                    '${x.prices.map((e) => e.unit.id).take(1).join()}')));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        elevation: 1.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              // fit: FlexFit.,
                              flex: 1,
                              child: Container(
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
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: size.width / 2.5,
                                // height: 300,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // SizedBox(height: size.height * 0.010),
                                    AutoSizeText('${x.name}',
                                        minFontSize: 10,
                                        maxFontSize: 12,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    ...x.prices
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
                                                  Radius.circular(30.0)),
                                              color: kBrandColor),
                                          margin: EdgeInsets.only(
                                              left: 1.25 *
                                                  SizeConfig.heightMultiplier,
                                              right: 1.25 *
                                                  SizeConfig.heightMultiplier,
                                              top: 10,
                                              //  5.0
                                              bottom: 10.0),
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
                                                    double.parse(x.prices
                                                        .map((e) =>
                                                            e.priceRegular)
                                                        .take(1)
                                                        .join()),
                                                    "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                    "${x.prices.map((e) => e.unit.abbreviation).take(1).join()}",
                                                    // '${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                    "${x.prices.map((e) => e.unit.id).take(1).join()}");
                                                // Provider.of<ProductsProvider>(context,
                                                //         listen: false)
                                                //     .setMeasurement(
                                                //         "${mes == x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == mes).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
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
        Shimmer.fromColors(
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
    // });
    // }});
  }
}

class CardItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback function;

  const CardItem({Key key, this.imageUrl, this.title, this.function})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Card(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Expanded(child: Text(title)),
          ],
        ),
      ),
    );
  }
}
