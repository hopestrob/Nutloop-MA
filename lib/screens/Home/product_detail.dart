import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Users/addCard.dart';
import 'widget/displayBottomSheet.dart';
import 'widget/featuredProduct.dart';
import 'package:provider/provider.dart';
import '../../helper/config_size.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails(
      this.productId,
      this.imageUrl,
      this.price,
      this.productName,
      this.description,
      this.category,
      this.farm,
      this.sku,
      this.freshness,
      this.deliveryDays,
      this.delveryArea,
      this.measurement,
      this.measurementId);
  final String description;
  final String imageUrl;
  final double price;
  final String productId;
  final String productName;
  final String category;
  final String farm;
  final String sku;
  final String freshness;
  final String deliveryDays;
  final String delveryArea;
  final String measurement;
  final String measurementId;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      // appBar: new
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            children: [
              new Container(
                margin: EdgeInsets.only(left: 15.0, right: 5.0),
                // width: 200,
                child: SafeArea(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                        child: Center(
                          child: Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back_ios,
                                      size: 30, color: greyColor2)),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(widget.productName,
                                    style: TextStyle(
                                        color: kBrandColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width / 1.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(widget.imageUrl),
                                      fit: BoxFit.cover)),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 30.0, bottom: 8.0),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        //  height: ,
                                        child: Text(widget.productName,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black)),
                                      ),
                                      Text(
                                          'N${widget.price.toString()}/${widget.measurement}',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: kBrandColor)),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      // margin: EdgeInsets.only(left:120.0),
                                      // width:10,
                                      height: 5 * SizeConfig.heightMultiplier,
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: TextButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .clear();
                                          displayBottomSheet(
                                              context,
                                              widget.productName,
                                              widget.productId,
                                              widget.price,
                                              widget.imageUrl,
                                              widget.measurement,
                                              widget.measurementId);
                                          //  Provider.of<ProductsProvider>(context, listen: false).setMeasurement(widget.measurement);
                                        },
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 1.88 *
                                                  SizeConfig.heightMultiplier),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.only(left: 15.0),
                                        child: IconButton(
                                            onPressed: () async {
                                              print(widget.productId);
                                              if (!await context
                                                  .read<ProductsProvider>()
                                                  .savedWhistList(
                                                      widget.productId)) {
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content:
                                                      Text('Product Saved'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ));
                                              }
                                            },
                                            icon: Icon(Icons
                                                .favorite_border_outlined))),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 30.0),
                            line(context),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text(widget.description),
                            ),
                            SizedBox(height: 30.0),
                            line(context),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 20.0, bottom: 30.0),
                                    child: Text(
                                      'Product Description',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Provider.of<ProductsProvider>(context,
                                                listen: false)
                                            .toggleDec();
                                      },
                                      child:
                                          Provider.of<ProductsProvider>(context)
                                                      .getdecVisible ==
                                                  false
                                              ? Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 30.0,
                                                )
                                              : Icon(Icons.arrow_forward_ios,
                                                  size: 20.0))
                                ],
                              ),
                            ),
                            Provider.of<ProductsProvider>(context)
                                        .getdecVisible ==
                                    false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        productDescription(
                                            'SKU',
                                            '${widget.sku}',
                                            TextDecoration.none),
                                        productDescription(
                                            'Category',
                                            '${widget.category}',
                                            TextDecoration.underline),
                                        productDescription('Stock', 'In Stock',
                                            TextDecoration.underline),
                                        productDescription(
                                            'Farm',
                                            '${widget.farm}',
                                            TextDecoration.none),
                                        productDescription(
                                            'Freshness',
                                            '${widget.freshness}',
                                            TextDecoration.none),
                                        productDescription(
                                            'Buy By',
                                            'pcs, kgs,box, pack',
                                            TextDecoration.none),
                                        productDescription(
                                            'Delivery',
                                            'in ${widget.deliveryDays} days',
                                            TextDecoration.none),
                                        productDescription(
                                            'Delivery Area',
                                            '${widget.delveryArea}',
                                            TextDecoration.none),
                                        SizedBox(
                                          height: 20.0,
                                        )
                                      ],
                                    ),
                                  ),
                            // : SizedBox()
                            line(context),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 20.0, bottom: 30.0),
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Provider.of<ProductsProvider>(context,
                                                listen: false)
                                            .toggleRev();
                                      },
                                      child:
                                          Provider.of<ProductsProvider>(context)
                                                      .getrevVisible ==
                                                  false
                                              ? Icon(Icons.arrow_drop_down,
                                                  size: 30.0)
                                              : Icon(Icons.arrow_forward_ios,
                                                  size: 20.0))
                                ],
                              ),
                            ),
                            Provider.of<ProductsProvider>(context)
                                        .getrevVisible ==
                                    false
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('No Review Yet'),
                                        SizedBox(
                                          height: 20.0,
                                        )
                                      ],
                                    ),
                                  )
                            // : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, bottom: 10.0, top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Similar Products',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FeaturedProduct(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

productDescription(
    String title, String decriptionName, TextDecoration textVal) {
  return ListTile(
    title: Text(title, style: TextStyle(color: greyColor3, fontSize: 20.0)),
    trailing: Container(
      width: 180.0,
      child: Text(
        decriptionName,
        style: TextStyle(decoration: textVal, fontSize: 18.0),
      ),
    ),
  );
}
