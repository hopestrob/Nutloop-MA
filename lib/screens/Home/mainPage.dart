import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/widget/checkOutAddCard.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages/AllBestDeal.dart';
import 'pages/allTopselling.dart';
import 'pages/featuredProduct.dart';
import 'pages/listProduct.dart';
import 'pages/recentlyViewed.dart';
// import 'widget/measurementBottom.dart';
import 'widget/partner.dart';
import 'widget/search.dart';
import 'widget/shippingads.dart';

// ignore: must_be_immutable
class MainProductPage extends StatefulWidget {
  const MainProductPage({Key key, this.authName}) : super(key: key);
  final String authName;

  @override
  _MainProductPageState createState() => _MainProductPageState();
}

class _MainProductPageState extends State<MainProductPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String firstname;
  // ignore: unused_field
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.nuthoop.com/join-us/osp/';
    const String toLaunch2 = 'https://www.nuthoop.com/join-us/supplier/';
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
                              // height: 400,
                              aspectRatio: 8 / 9,
                              viewportFraction: 1.2,
                              enableInfiniteScroll: true,
                              autoPlay: true),
                          items: [
                            'asset/slider.png',
                            'asset/images/banner.jpeg',
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
                                      width: 100),
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
                      height: 12.5 * SizeConfig.heightMultiplier,
                      //  150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          InkWell(
                            onTap: () => setState(() {
                              _launched = _launchInBrowser(toLaunch);
                            }),
                            child: PartnerBar(
                              color: productColor2,
                              text:
                                  'Register now to become a nuthoop Ordering Sales Partner and enjoy high commission, bonuses, support, training etc.',
                              title: 'Ordering Sales Partner',
                            ),
                          ),

                          InkWell(
                            onTap: () => setState(() {
                              _launched = _launchInBrowser(toLaunch2);
                            }),
                            child: PartnerBar(
                              color: Colors.red,
                              text:
                                  'Register now to enjoy regular offtake, access to loan, training and sustainable partnership.',
                              title: 'Become a Supplier',
                            ),
                          ),
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
                      height: 15.8 * SizeConfig.heightMultiplier,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ShippingAdBar(
                            widget: SvgPicture.asset(
                              "asset/icons/free-delivery.svg",
                              height: 6.88 * SizeConfig.heightMultiplier,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              // 260
                            ),
                            title: 'FREE SHIPPING',
                            content: 'For all orders over ₦30,000.00',
                          ),
                          ShippingAdBar(
                            widget: SvgPicture.asset(
                              "asset/creditcard.svg",
                              height: 6.88 * SizeConfig.heightMultiplier,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              // 260
                            ),
                            title: 'SECURE PAYMENT',
                            content: '100% secure online payment',
                          ),
                          ShippingAdBar(
                            widget: SvgPicture.asset(
                              "asset/icons/support.svg",
                              height: 6.88 * SizeConfig.heightMultiplier,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              // 260
                            ),
                            title: 'ONLINE SUPPORT',
                            content: '24/7 Dedicated customers support',
                          ),
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
                          // Text(
                          //   'View All Products',
                          //   style: TextStyle(color: kBrandColor),
                          // )
                        ],
                      ),
                    ),
                    RecentlyViewed(),
                    line(context),
                    SizedBox(height: size.height * 0.010),
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
        // Expanded(
        //   child: InkWell(
        //     onTap: () {
        //       Provider.of<ProductsProvider>(context, listen: false)
        //           .clearMeasurement();
        //       measurementBottomSheet(context, selectedUnit);
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 10.0),
        //       child:
        //           Provider.of<ProductsProvider>(context).getMeasurement == null
        //               ? Row(
        //                   children: [
        //                     Text('Measurement'),
        //                     Icon(Icons.keyboard_arrow_down_sharp)
        //                   ],
        //                 )
        //               : Row(
        //                   children: [
        //                     Text(Provider.of<ProductsProvider>(context)
        //                         .getMeasurement
        //                         .toString()),
        //                     Icon(Icons.keyboard_arrow_down_sharp)
        //                   ],
        //                 ),
        //     ),
        //   ),
        // )
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
