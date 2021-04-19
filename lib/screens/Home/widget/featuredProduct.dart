// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Home/product_detail.dart';
import 'package:provider/provider.dart';
import '../../Auth/constants.dart';
import 'displayBottomSheet.dart';
import '../../../helper/config_size.dart';

class FeaturedProduct extends StatefulWidget {

  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {

  @override
  Widget build(BuildContext context) {
           Size size = MediaQuery.of(context).size;
    return Consumer<ProductsProvider>(
                    builder: (context, prod, child) {
                  final products = prod.getProductBestDeal;
               
               return products == null ? SizedBox():
                   Container(
                    margin: EdgeInsets.all(10.0),
                    height: 27.955 * SizeConfig.heightMultiplier,

                    // 223, 27.955
                    // 32.59 * SizeConfig.heightMultiplier
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: products == null ? 0 : products.length,
                      itemBuilder: (context, index) {
                            var image = json.decode( products[index].images) as List;
                        return InkWell(
                         onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                        products[index].id.toString(),
                                        "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                       double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).join():products[index].prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).join()),
                                        products[index].name,
                                       products[index].description,
                                       products[index].category.name,
                                       products[index].farm,
                                       products[index].sku,
                                       products[index].freshness,
                                       products[index].deliveryDays,
                                       products[index].deliveryArea,
                                       '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).join(): "kg"}',
                                       "${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).join(): "2"}"
                                       )));
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
                                  Container(
                                    width:
                                        size.width / 2.5,
                                    height:14 * SizeConfig.heightMultiplier,
                                    // 117,
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
                                    height: 1.0  * SizeConfig.heightMultiplier),
                                  Container(
                                    width:
                                        size.width / 2.5,
                                    height: 11.28  * SizeConfig.heightMultiplier,
                                    // 90,
                                        
                                    // color: Theme.of(context).primaryColor.withOpacity(.5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        // SizedBox(height: size.height * 0.010),
                                        Text('${products[index].name}',
                                            style: TextStyle(fontSize: 
                                            1.88 * SizeConfig.heightMultiplier
                                            // 15.0
                                            ),
                                            overflow: TextOverflow.ellipsis),
                                      Text('#${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).join():products[index].prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).join()}/${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ?  products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).join(): "kg"}',
                                        // Text('#${products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).join()}/${products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).join()}',
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
                                            height: 4.3876 *  SizeConfig.heightMultiplier,
                                            //  35.0,
                                            // ,
                                            child: FlatButton(
                                                onPressed: () {
                                                    displayBottomSheet(
                                                      context,
                                                      products[index].name,
                                                      products[index].id.toString(),
                                                      double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).join():products[index].prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).join()),
                                                      "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                      "${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).join(): "kg"}",
                                                      "${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).join(): "2"}"
                                                    );
                                                      Provider.of<ProductsProvider>(context, listen: false).setMeasurement("${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).join() ? products[index].prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).join(): "kg"}");
                                                    },  
                                                child: Text(
                                                  'Add to Cart',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )))
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
                  );
                });
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
