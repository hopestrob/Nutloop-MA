import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/displayBottomSheet.dart';
import 'package:provider/provider.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import '../../screens/Home/homepage.dart';
import '../../screens/Home/allProducts.dart';
import '../../screens/Home/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Home/widget/header.dart';

// ignore: must_be_immutable
class SavedProductScreen extends StatefulWidget {
  @override
  _SavedProductScreenState createState() => _SavedProductScreenState();
}

class _SavedProductScreenState extends State<SavedProductScreen> {
  TextEditingController firstName = TextEditingController();

  TextEditingController lastName = TextEditingController();

  TextEditingController phone = TextEditingController();
  PageController pageController;
  int pageIndex = 3;

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
        pageIndex = pageIndex;
      });
    }
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false).getSavedItemsList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          children: [
            Column(children: [
              Container(child: header(context, "Saved Items")),
              SizedBox(height: 10),
              Expanded(
                  child: Container(
                color: greyColor5,
                child: Consumer<ProductsProvider>(
                    builder: (_, savedItem, child) => ListView(
                            children: List.generate(
                                savedItem.getSavedItem.length, (index) {
                          var image = json.decode(
                                  savedItem.getSavedItem[index].product.images)
                              as List;
                          // print(image.map((e) => e.toString()).join());
                          // print("${Api.imageUrl}${savedItem.getSavedImage}");
                          final prod = savedItem.getSavedItem[index].product;
                          return Card(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 15.0),
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
                                          child: Text(prod.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey)),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          '#${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '') : prod.prices.where((e) => e.unitId == 2).map((e) => e.priceRegular).toString().replaceAll('(', '').replaceAll(')', '')}/${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12.0),
                                        ),
                                        SizedBox(
                                          height: 25.0,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50.0)),
                                                color: kBrandColor),
                                            // margin: EdgeInsets.all(10.0),
                                            height: 35.0,
                                            // ,
                                            child: FlatButton(
                                                onPressed: () {
                                                  displayBottomSheet(
                                                      context,
                                                      prod.name,
                                                      prod.id.toString(),
                                                      double.parse(Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '')
                                                          ? prod.prices
                                                              .where((e) =>
                                                                  e.unit.name.toString() ==
                                                                  Provider.of<ProductsProvider>(context, listen: false)
                                                                      .getMeasurement)
                                                              .map((e) => e
                                                                  .priceRegular)
                                                              .toString()
                                                              .replaceAll(
                                                                  '(', '')
                                                              .replaceAll(
                                                                  ')', '')
                                                          : prod.prices
                                                              .where((e) => e.unitId == 2)
                                                              .map((e) => e.priceRegular)
                                                              .toString()
                                                              .replaceAll('(', '')
                                                              .replaceAll(')', '')),
                                                      "${Api.imageUrl}${image.map((e) => e.toString()).join()}",
                                                      '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}',
                                                      '${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.id).toString().replaceAll('(', '').replaceAll(')', '') : "2"}');
                                                  Provider.of<ProductsProvider>(
                                                          context,
                                                          listen: false)
                                                      .setMeasurement(
                                                          "${Provider.of<ProductsProvider>(context, listen: false).getMeasurement == prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.name).toString().replaceAll('(', '').replaceAll(')', '') ? prod.prices.where((e) => e.unit.name.toString() == Provider.of<ProductsProvider>(context, listen: false).getMeasurement).map((e) => e.unit.abbreviation).toString().replaceAll('(', '').replaceAll(')', '') : "kg"}");
                                                },
                                                child: Text(
                                                  'Add to Cart',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )))
                                      ],
                                    ),
                                      ],
                                    ),
                                    
                                    Container(
                                      margin: EdgeInsets.only(right:20.0),
                                        padding: EdgeInsets.all(5.0),
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            border: Border.all(
                                                // width: 3.0,
                                                color: kPrimaryColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0))),
                                        child: InkWell(
                                            onTap: () {
                                              print('hello');
                                               Provider.of<ProductsProvider>(context, listen: false).removeItem(savedItem.getSavedItem[index].id.toString());
                                            },
                                            child: Icon(FontAwesomeIcons.trash,
                                                color: Colors.white)))
                                  ],
                                )
                              ],
                            ),
                          );
                        }))),
              ))
              // Text(savedItem.getSavedItem.)))
            ]),
            Consumer<Authentication>(
                builder: (_, authuser, child) => Homepage(
                    authName: "${authuser.getAuthUser}", selectedPage: 0)),
            AllProducts(),
            CartScreen(),
            // ProfileScreen(),
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
                icon: Icon(
                  Icons.home,
                  color: greyColor2,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: kBrandColor,
                ),
                // ignore: deprecated_member_use
                title: Text(
                  'Home',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon:
                    Icon(Icons.format_list_bulleted_rounded, color: greyColor2),
                activeIcon: Icon(Icons.format_list_bulleted_rounded,
                    color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'All Products',
                  style: TextStyle(color: greyColor2),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart, color: greyColor2),
                activeIcon: Icon(Icons.shopping_cart, color: kBrandColor),
                // ignore: deprecated_member_use
                title: Text(
                  'Cart',
                  style: TextStyle(color: greyColor2),
                )),
            // BottomNavigationBarItem(icon: Icon(Icons.search, color: greyColor2), title: Text('Advance Search', style: TextStyle(color:Colors.black),)),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Consumer<Authentication>(
                                builder: (_, authuser, child) => Homepage(
                                    authName: "${authuser.getAuthUser}",
                                    selectedPage: 3)),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    icon: Icon(FontAwesomeIcons.userCircle, color: greyColor2)),
                activeIcon: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => Consumer<Authentication>(
                                builder: (_, authuser, child) => Homepage(
                                    authName: "${authuser.getAuthUser}",
                                    selectedPage: 3)),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    icon:
                        Icon(FontAwesomeIcons.userCircle, color: kBrandColor)),
                // ignore: deprecated_member_use
                title: Text(
                  'Profile',
                  style: TextStyle(color: greyColor2),
                )),
          ]),
    );
  }
}
