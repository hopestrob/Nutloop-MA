import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/model/unitModel.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/listProduct.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'AllBestDeal.dart';
import 'allTopselling.dart';
import 'checkOutAddCard.dart';
import 'widget/featuredProduct.dart';
import 'widget/partner.dart';
import 'widget/search.dart';
import 'widget/shippingads.dart';

// ignore: must_be_immutable
class MainProductPage extends StatefulWidget {
  final String authName;
  MainProductPage({this.authName});

  @override
  _MainProductPageState createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage> {
  String firstname;

  @override
  Widget build(BuildContext context) {
    var names = widget.authName.split(' ');
    setState(() {
      firstname = names[0];
    });
    Size size = MediaQuery.of(context).size;
    Provider.of<ProductsProvider>(context).getUnit();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                new Container(
                  margin: EdgeInsets.only(left: 15.0, right: 5.0),
                  // width: 200,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.030),
                      buildActionbar('Hi $firstname', context),
                      SizedBox(height: size.height * 0.020),
                      buildSearchRow(),
                      SizedBox(height: size.height * 0.010),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(children: <Widget>[
                    Container(
                        height: size.height * 0.200,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              height: 400,
                              enableInfiniteScroll: true,
                              autoPlay: true),
                          items: [
                            'asset/slider.png',
                            'asset/slider.png',
                            'asset/slider.png',
                            'asset/slider.png',
                          ].map(
                            (i) {
                              return Container(
                                width: size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                // decoration: BoxDecoration(color: Colors.amber),
                                child: GestureDetector(
                                  child: Image.asset(i,
                                      fit: BoxFit.fill,
                                      height: 400,
                                      width: 1000),
                                  onTap: () {
                                    // print('hello');
                                  },
                                ),
                              );
                            },
                          ).toList(),
                        )),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Best Deals',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllBestDealProductScreen()));
                            },
                            child: Text(
                              'View All Products',
                              style: TextStyle(color: kBrandColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    FeaturedProduct(),
                    // SizedBox(height: 20.0),
                    line(context),
                    Container(
                      // width: size.
                      // * SizeConfig.heightMultiplier
                      height: 20.5 * SizeConfig.heightMultiplier,
                      //  150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          PartnerBar(color: productColor2),
                          PartnerBar(color: Colors.red),
                          // PartnerBar(color: productColor),
                          // PartnerBar(color: productColor2),
                        ],
                      ),
                    ),
                    line(context),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Selling Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllTopSellingProductScreen()));
                            },
                            child: Text(
                              'View All Products',
                              style: TextStyle(color: kBrandColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListProduct(),
                    line(context),
                    Container(
                      height: 20.5 * SizeConfig.heightMultiplier,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ShippingAdBar(),
                          ShippingAdBar(),
                          // ShippingAdBar(),
                          // ShippingAdBar(),
                        ],
                      ),
                    ),
                    line(context),
                    SizedBox(height: size.height * 0.010),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recently Viewed Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'View All Products',
                            style: TextStyle(color: kBrandColor),
                          )
                        ],
                      ),
                    ),
                    // ListProduct(),
                    // SvgPicture.asset(
                    //   "asset/icons/chat.svg",
                    //   height: size.width * 0.330,
                    //   color: kBrandColor,
                    // ),
                    // line(context),
                    // SizedBox(height: size.height * 0.010),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildActionbar(String authName, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {print('Hello')},
                child: CircleAvatar(
                  radius: 4.86 * SizeConfig.widthMultiplier,
                  // 20,
                  backgroundColor: kBrandColor,
                  child: Icon(
                    Icons.person,
                    size: 9.7228974 * SizeConfig.widthMultiplier,
                    // 40.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 36.46 * SizeConfig.widthMultiplier,
                  // 150.0,
                  child: Text(
                    authName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kBrandColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                    child: new DropdownButton<String>(
                        hint: Provider.of<ProductsProvider>(context)
                                    .getMeasurement ==
                                null
                            ? Text('Measurement')
                            : Text(Provider.of<ProductsProvider>(context)
                                .getMeasurement
                                .toString()),
                        value: selectedUnit,
                        isDense: true,
                        onChanged: (value) {
                          Provider.of<ProductsProvider>(context, listen: false)
                              .measurementState(value);
                          // print('this os the value $value');
                        },
                        items: Provider.of<ProductsProvider>(context)
                            .getUnits
                            .map((UnitModel map) {
                          return new DropdownMenuItem<String>(
                            value: map.name,
                            child: new Text(map.name,
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 15.0)),
                          );
                        }).toList())),
              ],
            ),
          ),
        )
        //  Consumer<Cart>(
        //       builder: (_, cartObject, child) => Badge(
        //         child: child,
        //         value: cartObject.itemCount.toString(),
        //       ),
        //       child: IconButton(
        //         icon: Icon(Icons.shopping_cart),
        //         onPressed: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
        //         },
        //       ),
        //     ),
      ],
    );
  }

  String selectedUnit;
}

class UserWidget extends StatelessWidget {
  final String productName;
  final String price;
  final String imageURL;

  const UserWidget({Key key, this.productName, this.price, this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 670, top: 50.0),
      child: Card(
        elevation: 8,
        child: new Container(
          decoration: new BoxDecoration(
              border: new Border.all(width: 1.0, color: Colors.grey),
              color: Colors.white70),
          margin: new EdgeInsets.symmetric(vertical: 1.0),
          child: Column(
            children: [
              Image.asset(imageURL, height: 20, width: 20),
              Text(productName),
              Text(price),
            ],
          ),
        ),
      ),
    );
  }
}
