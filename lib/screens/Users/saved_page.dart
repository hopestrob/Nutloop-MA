import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/helper/api.dart';
// import 'package:nuthoop/screens/Home/bottomNav.dart';
import 'package:nuthoop/screens/Home/mainPage.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
import 'package:nuthoop/screens/Home/widget/progressdialog.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Home/widget/header.dart';

// ignore: must_be_immutable
class SavedProductScreen extends StatefulWidget {
  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  @override
  void didChangeDependencies() {
    if (!mounted) return;
    Provider.of<ProductsProvider>(context, listen: false).getSavedItemsList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: SafeArea(
            top: false,
            child: Column(children: [
              Container(child: header(context, "Saved Items")),
              SizedBox(height: 10),
              Expanded(
                  child: Container(
                color: greyColor5,
                child: Consumer<ProductsProvider>(
                    builder: (_, savedItem, child) => savedItem
                                .getSavedItem.length ==
                            0
                        ? Container(
                            color: greyColor5,
                            child: ListView(
                              children: [
                                SizedBox(height: size.height * 0.150),
                                SvgPicture.asset(
                                  "asset/cart.svg",
                                  height: size.width * 0.330,
                                  color: kBrandColor,
                                ),
                                Container(
                                    width: 250,
                                    margin: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      'You currently have no Whistlist Item!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24.0),
                                    )),
                                Container(
                                  margin: EdgeInsets.all(
                                      5.0 * SizeConfig.widthMultiplier),
                                  width: 95 * SizeConfig.widthMultiplier,
                                  padding: EdgeInsets.all(10.0),
                                  // width: size.width / 1.2,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Consumer<
                                                      Authentication>(
                                                  builder: (_, authuser,
                                                          child) =>
                                                      MainProductPage(
                                                          authName:
                                                              "${authuser.getAuthUser}"))));
                                    },
                                    child: Text(
                                      'Continue Shopping',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.020),
                              ],
                            ),
                          )
                        : ListView(
                            children: List.generate(
                                savedItem.getSavedItem.length, (index) {
                            var image = json.decode(savedItem
                                .getSavedItem[index].product.images) as List;
                            // print(image.map((e) => e.toString()).join());
                            // print("${Api.imageUrl}${savedItem.getSavedImage}");
                            final prod = savedItem.getSavedItem[index].product;
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(right: 15.0),
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${Api.imageUrl}${image.map((e) => e.toString()).join()}"),
                                                    fit: BoxFit.cover)),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 130.0,
                                                child: AutoSizeText(
                                                    '${prod.name}',
                                                    minFontSize: 10,
                                                    maxFontSize: 12,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey)),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              ...prod.prices
                                                  // .where((e) => e.unitId == 1)
                                                  .map((e) => AutoSizeText(
                                                        '₦${e.priceRegular}/${e.unit.abbreviation}',
                                                        minFontSize: 10,
                                                        maxFontSize: 12,
                                                        maxLines: 2,
                                                      ))
                                                  .take(1),
                                              SizedBox(
                                                height: 25.0,
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50.0)),
                                                      color: kBrandColor),
                                                  // margin: EdgeInsets.all(10.0),
                                                  height: 35.0,
                                                  // ,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Provider.of<CartProvider>(
                                                                context,
                                                                listen: false)
                                                            .clear();
                                                        displayBottomSheet(
                                                            context,
                                                            prod.name,
                                                            prod.id.toString(),
                                                            double.parse(prod
                                                                .prices
                                                                .map((e) => e
                                                                    .priceRegular)
                                                                .take(1)
                                                                .join()),
                                                            "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                            '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                            "${prod.prices.map((e) => e.unit.id).take(1).join()}");
                                                      },
                                                      child: Text(
                                                        'Add to Cart',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )))
                                            ],
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                Future.delayed(
                                                    Duration(seconds: 5), () {
                                                  Navigator.pop(context);
                                                });
                                                return ProgressDialog(
                                                  message: "Please Wait..",
                                                );
                                              }).then((_) {
                                            // async{
                                            //  bool suc = await
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .removeItem(savedItem
                                                    .getSavedItem[index].id
                                                    .toString())
                                                .then((_) => {
                                                      Provider.of<ProductsProvider>(
                                                              context,
                                                              listen: false)
                                                          .getSavedItemsList()
                                                    });
                                          });
                                        },
                                        child: Container(
                                            margin:
                                                EdgeInsets.only(right: 20.0),
                                            padding: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                border: Border.all(
                                                    // width: 3.0,
                                                    color: kPrimaryColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0))),
                                            child: Icon(FontAwesomeIcons.trash,
                                                color: Colors.white)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }))),
              ))
              // Text(savedItem.getSavedItem.)))
            ]),
          ),
        ));
  }
}
