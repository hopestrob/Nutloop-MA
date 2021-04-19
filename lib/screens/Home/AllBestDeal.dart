import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
// import 'package:nutloop_ecommerce/model/products.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:nutloop_ecommerce/screens/Home/product_detail.dart';
import 'package:nutloop_ecommerce/screens/Users/profile.dart';
import 'package:provider/provider.dart';

import 'allProducts.dart';
import 'cart_screen.dart';
import 'widget/displayBottomSheet.dart';
import 'widget/search.dart';
import '../../helper/config_size.dart';

class AllBestDealProductScreen extends StatefulWidget {
  @override
  _AllBestDealProductScreenState createState() =>
      _AllBestDealProductScreenState();
}

class _AllBestDealProductScreenState
    extends State<AllBestDealProductScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    if (mounted) {
      setState(() {
        this.pageIndex = pageIndex;
      });
    }
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Future<List<ProductModel>> getproductTop() =>
    //     ProductsProvider().getproductTopDeals();
     Provider.of<Authentication>(context).setAuthUser();
    // Future<List<ProductModel>> _future =
        Provider.of<ProductsProvider>(context, listen: false)
            .getAllproductBestDeals();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          children: [
            GestureDetector(
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
                                width: MediaQuery.of(context).size.width / 2.0,
                                child: Text('All Best Deals',
                                    // textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: kBrandColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                children: [
                                  new DropdownButton<String>(
                                     hint: Provider.of<ProductsProvider>(context).getMeasurement == null ? Text('Measurement') : Text(Provider.of<ProductsProvider>(context).getMeasurement.toString()),
                                    items: <String>[
                                      'Kilogram',
                                      'Pieces',
                                      'Box',
                                      'Packet'
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value==null ? 'kg': value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      Provider.of<ProductsProvider>(context,
                                              listen: false)
                                          .measurementState(value);
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductByMeasurement()));
                                      print(Provider.of<ProductsProvider>(
                                              context,
                                              listen: false)
                                          .getMeasurement);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                          SizedBox(height: size.height * 0.020),
                            buildSearchRow(),
                             SizedBox(height: size.height * 0.010),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        // FutureBuilder(
                        //     future: _future,
                        //     builder: (context, snapshot) {
                        //       switch (snapshot.connectionState) {
                        //         case ConnectionState.waiting:
                        //           return Center(
                        //             child: CupertinoActivityIndicator(
                        //               radius: 12,
                        //             ),
                        //           );
                        //         // return SizedBox();
                        //         default:
                        //           if (snapshot.hasData==null || snapshot.data == null)
                        //             return Center(
                        //                 heightFactor: 2,
                        //                 child: Text('Try Again Later'));
                        //           else if (snapshot.hasError || snapshot.error)
                        //             return Center(
                        //                 heightFactor: 2,
                        //                 child: Text('Try Again Later'));
                        //           else
                        //             return
                                     Consumer<ProductsProvider>(
                                        builder: (context, prod, child) {
                                      final products =
                                          prod.getAllProductBestDeal;
                                      return products == null
                                          ? SizedBox()
                                          : Container(
                                              margin: EdgeInsets.all(10.0),
                                              // height: MediaQuery.of(context).size.height / 2.0,
                                              child: GridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: SizeConfig.isPortrait ? 2 : 3,
                                                crossAxisSpacing: 1.0,
                                                childAspectRatio:
                                                    SizeConfig.isPortrait ? 0.2125 * SizeConfig.widthMultiplier : 0.2125 * SizeConfig.widthMultiplier / 0.8,
                                                mainAxisSpacing: 5.0,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                children: List.generate(
                                                    products == null
                                                        ? 0
                                                        : products.length, (i) {
                                                  final x = products[i];
                                                   var image = json.decode( products[i].images) as List;
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => ProductDetails(
                                                                  x.id
                                                                      .toString(),
                                                                "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                  double.parse(Provider.of<ProductsProvider>(context, listen: false)
                                                                              .getMeasurement ==
                                                                          x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(
                                                                              ')',
                                                                              '')
                                                                      ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(
                                                                          ')',
                                                                          '')
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
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                      elevation: 1.0,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                                 width: size.width > 412 ? size.width * 050 : size.width * 0.50,
                                                                 height: 12.8 * SizeConfig.heightMultiplier,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10.0)),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        "${Api.imageUrl}${image.map((e) => e.toString()).join()}",),
                                                                    fit: BoxFit
                                                                        .cover)),
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                2.5,
                                                            // height: 300,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Text(
                                                                    '${x.name}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15.0),
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
                                                                            BorderRadius.all(Radius.circular(
                                                                                50.0)),
                                                                        color:
                                                                            kBrandColor),
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                    height:
                                                                        35.0,
                                                                    // ,
                                                                    child: FlatButton(
                                                                        onPressed: () {
                                                                          displayBottomSheet(
                                                                              context,
                                                                              x.name,
                                                                              x.id.toString(),
                                                                              double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '') : x.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')),
                                                                              "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                                              '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                                              '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}',
                                                                              );
                                                                          Provider.of<ProductsProvider>(context, listen: false)
                                                                              .setMeasurement("${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? x.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
                                                                        },
                                                                        child: Text(
                                                                          'Add to Cart',
                                                                          style:
                                                                              TextStyle(color: Colors.white),
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
             AllProducts(),
            CartScreen(),
            ProfileScreen()
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          currentIndex: pageIndex,
          onTap: onTap,
          selectedItemColor: kBrandColor,
          unselectedItemColor: greyColor2,
          items: [
            BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: (){
                    print('tabed $pageIndex');
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                       Consumer<Authentication>(
                            builder: (_, authuser, child) => Homepage(authName:"${authuser.getAuthUser}", selectedPage: 0)),), (Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.home),
                  color: greyColor2,
                ),
                activeIcon:IconButton(
                  onPressed: (){
                    print('tabed $pageIndex');
                     Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                       Consumer<Authentication>(
                            builder: (_, authuser, child) => Homepage(authName:"${authuser.getAuthUser}", selectedPage: 0)),), (Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.home),
                  color: kBrandColor,
                ),                
                // ignore: deprecated_member_use
                title: Text(
                  'Home',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_rounded, color: greyColor2),
                activeIcon:Icon(Icons.format_list_bulleted_rounded, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'All Products',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: greyColor2),
                activeIcon:Icon(Icons.shopping_cart, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Cart',
                  style: TextStyle(color: greyColor2),
                )),
            // BottomNavigationBarItem(icon: Icon(Icons.search, color: greyColor2), title: Text('Advance Search', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userCircle, color: greyColor2),
                activeIcon:Icon(FontAwesomeIcons.userCircle, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Profile',
                  style: TextStyle(color: greyColor2),
                )),
          ]),
    );
  }
}
