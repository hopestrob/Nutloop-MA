import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/model/Product_review.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Home/widget/displayBottomSheet.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';
import 'package:nuthoop/screens/Home/widget/measurementBottom.dart';
import 'package:nuthoop/screens/Home/widget/progressdialog.dart';
import 'package:nuthoop/screens/Users/addCard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'featuredProduct.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
  // ValueNotifier<bool> _textHasErrorNotifier = ValueNotifier(false);
  var items = [];
  String selectedUnit;
  Api api = new Api();
  ProductModelReview _getProduct = ProductModelReview();
  var imageUrl;
  List newimage = [];
  var rating = 0.0;
  final txtCommentController = TextEditingController();

  Future<ProductModelReview> productDetails() async {
    try {
      var response = await api.getProductDetails(int.parse(widget.productId));
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        // var list = result['data']['results'] as List;
        setState(() {
          imageUrl = json.decode(result['data']['images']);
          _getProduct = ProductModelReview.fromJson(result['data']);
        });
      }
      // print(
      // 'this is new Image ${imageUrl.toString().replaceAll('[', '').replaceAll(']', '')}  and new ${imageUrl?.join()}');
      return _getProduct;
    } catch (exception) {
      print('this is product detail page exception $exception');
      return null;
    }
  }

  @override
  void didChangeDependencies() {
    if (!mounted) return;
    // Provider.of<ProductsProvider>(context, listen: false).getSavedItemsList();
    productDetails();
    setState(() {
      items =
          Provider.of<ProductsProvider>(context, listen: false).getSavedItem;
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    productDetails();
    super.initState();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: roundedButton(
                    "No", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
              ),
              SizedBox(
                height: 10.0,
              ),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: roundedButton(
                    " Yes ", const Color(0xFF167F67), const Color(0xFFFFFFFF)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: _getProduct.id == null
              ? Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: true,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      margin: EdgeInsets.all(10.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          1,
                          (index) => Column(
                            children: [
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 1,
                                        color: kBrandColor),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
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
                )
              : Container(
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
                                padding: const EdgeInsets.only(
                                    top: 40.0, bottom: 20.0),
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
                                        padding:
                                            const EdgeInsets.only(left: 30.0),
                                        child: Text(_getProduct.name,
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
                                      height:
                                          MediaQuery.of(context).size.width /
                                              1.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0)),
                                      ),
                                      child:
                                          // imageUrl == null
                                          //     ?
                                          //     :
                                          Image.network(
                                        "${Api.imageUrl}${imageUrl.join()}",
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
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 30.0, bottom: 8.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  //  height: ,
                                                  child: Text(_getProduct.name,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black)),
                                                ),
                                                ..._getProduct.prices
                                                    .where((e) =>
                                                        e.productId ==
                                                        int.parse(
                                                            widget.productId))
                                                    .map((e) => AutoSizeText(
                                                          '₦${_getProduct.prices.where((prodI) => prodI.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context).getMeasurement.toString()).map((chanP) => chanP.priceRegular).take(1).join() == '' ? e.priceRegular : _getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context).getMeasurement.toString()).map((e) => e.priceRegular).take(1).join()}/${_getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context).getMeasurement.toString()).map((e) => e.priceRegular).take(1).join() == '' ? e.unit.abbreviation : Provider.of<ProductsProvider>(context).getMeasurement} ',
                                                          minFontSize: 10,
                                                          maxFontSize: 12,
                                                          maxLines: 2,
                                                        ))
                                                    .take(1),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            flex: 4,
                                            child: InkWell(
                                              onTap: () {
                                                // Provider.of<ProductsProvider>(
                                                //         context,
                                                //         listen: false)
                                                //     .clearMeasurement();
                                                measurementBottomSheet(
                                                    context, selectedUnit);
                                              },
                                              child:
                                                  Provider.of<ProductsProvider>(
                                                                  context)
                                                              .getMeasurement ==
                                                          null
                                                      ? Row(
                                                          children: [
                                                            Text('Kg'),
                                                            Icon(Icons
                                                                .keyboard_arrow_down_sharp)
                                                          ],
                                                        )
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: 50,
                                                              // height: 120,
                                                              child:
                                                                  AutoSizeText(
                                                                Provider.of<ProductsProvider>(
                                                                        context)
                                                                    .getMeasurement
                                                                    .toString(),
                                                                minFontSize: 10,
                                                                maxFontSize: 12,
                                                                maxLines: 3,
                                                              ),
                                                            ),
                                                            Icon(Icons
                                                                .keyboard_arrow_down_sharp)
                                                          ],
                                                        ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: 4 *
                                                  SizeConfig.heightMultiplier,
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0)),
                                              child: TextButton(
                                                onPressed: () {
                                                  Provider.of<CartProvider>(
                                                          context,
                                                          listen: false)
                                                      .clear();
                                                  displayBottomSheet(
                                                    context,
                                                    _getProduct.name,
                                                    _getProduct.id.toString(),
                                                    double.parse(
                                                        '${_getProduct.prices.where((prodI) => prodI.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()).map((chanP) => chanP.priceRegular).take(1).join() == '' ? double.parse(_getProduct.prices.map((e) => e.priceRegular).take(1).join()) : _getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context).getMeasurement.toString()).map((e) => e.priceRegular).take(1).join()}'),
                                                    "${Api.imageUrl}${imageUrl.join()}",
                                                    '${_getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()).map((e) => e.priceRegular).take(1).join() == '' ? _getProduct.prices.map((e) => e.unit.abbreviation).take(1).join() : _getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()).map((e) => e.unit.abbreviation).take(1).join()}',
                                                    '${_getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()).map((e) => e.priceRegular).take(1).join() == '' ? _getProduct.prices.map((e) => e.unit.id).take(1).join() : _getProduct.prices.where((prodId) => prodId.productId == int.parse(widget.productId)).where((unit) => unit.unit.name == Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()).map((e) => e.unit.id).take(1).join()}',
                                                  );
                                                  //  Provider.of<ProductsProvider>(context, listen: false).setMeasurement(widget.measurement);
                                                },
                                                child: Text(
                                                  'Add to Cart',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 1.55 *
                                                          SizeConfig
                                                              .heightMultiplier),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: items
                                                    .map((e) => e.productId)
                                                    .cast()
                                                    .contains(_getProduct.id)
                                                ? GestureDetector(
                                                    onTap: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 2),
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                            return ProgressDialog(
                                                              message:
                                                                  "Please Wait removing..",
                                                            );
                                                          }).then((_) {
                                                        // async{
                                                        //  bool suc = await
                                                        Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .removeItem(items
                                                                .where((e) =>
                                                                    e.productId ==
                                                                    _getProduct
                                                                        .id)
                                                                .map(
                                                                    (e) => e.id)
                                                                .join()
                                                                .toString())
                                                            .then(
                                                                (_) => {
                                                                      Provider.of<ProductsProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .getSavedItemsList()
                                                                    })
                                                            .then((_) => {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    backgroundColor:
                                                                        kBrandColor,
                                                                    content: Text(
                                                                        'Product Removed'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            3),
                                                                  ))
                                                                });
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15.0),
                                                      child: Icon(
                                                          Icons.favorite_sharp,
                                                          color: Colors.red),
                                                    ))
                                                : GestureDetector(
                                                    onTap: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 2),
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                            return ProgressDialog(
                                                              message:
                                                                  "Please Wait adding..",
                                                            );
                                                          }).then((_) {
                                                        // async{
                                                        //  bool suc = await
                                                        Provider.of<ProductsProvider>(
                                                                context,
                                                                listen: false)
                                                            .savedWhistList(
                                                                _getProduct.id
                                                                    .toString())
                                                            .then(
                                                                (_) => {
                                                                      Provider.of<ProductsProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .getSavedItemsList()
                                                                    })
                                                            .then((_) => {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          SnackBar(
                                                                    backgroundColor:
                                                                        kBrandColor,
                                                                    content: Text(
                                                                        'Product Saved'),
                                                                    duration: Duration(
                                                                        seconds:
                                                                            3),
                                                                  ))
                                                                });
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 15.0),
                                                      child: Icon(
                                                        Icons
                                                            .favorite_border_outlined,
                                                      ),
                                                    )),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30.0),
                                    line(context),
                                    SizedBox(height: 10.0),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Text(_getProduct.description),
                                    ),
                                    SizedBox(height: 30.0),
                                    line(context),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 20.0,
                                                bottom: 30.0),
                                            child: Text(
                                              'Product Description',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleDec();
                                              },
                                              child:
                                                  Provider.of<ProductsProvider>(
                                                                  context)
                                                              .getdecVisible ==
                                                          false
                                                      ? Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 30.0,
                                                        )
                                                      : Icon(
                                                          Icons
                                                              .arrow_forward_ios,
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
                                                    '${_getProduct.sku}',
                                                    TextDecoration.none),
                                                productDescription(
                                                    'Category',
                                                    '${_getProduct.category.name}',
                                                    TextDecoration.underline),
                                                ListTile(
                                                  title: Text('Stock',
                                                      style: TextStyle(
                                                          color: greyColor3,
                                                          fontSize: 20.0)),
                                                  trailing: Container(
                                                    width: 180.0,
                                                    child: _getProduct.id !=
                                                            null
                                                        ? Text(
                                                            'In Stock',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .green),
                                                          )
                                                        : Text('In Stock',
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .red)),
                                                  ),
                                                ),
                                                // productDescription('Stock', 'In Stock',
                                                //     TextDecoration.underline),
                                                productDescription(
                                                    'Farm',
                                                    '${_getProduct.farm}',
                                                    TextDecoration.none),
                                                productDescription(
                                                    'Freshness',
                                                    '${_getProduct.freshness}',
                                                    TextDecoration.none),
                                                productDescription(
                                                    'Buy By',
                                                    'pcs, kgs,box, pack',
                                                    TextDecoration.none),
                                                productDescription(
                                                    'Delivery',
                                                    'in ${_getProduct.deliveryDays} days',
                                                    TextDecoration.none),
                                                productDescription(
                                                    'Delivery Area',
                                                    '${_getProduct.deliveryArea}',
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
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 20.0,
                                                bottom: 30.0),
                                            child: Text(
                                              'Product Reviews',
                                              style: TextStyle(fontSize: 18.0),
                                            ),
                                          ),
                                          InkWell(
                                              onTap: () {
                                                Provider.of<ProductsProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleRev();
                                              },
                                              child:
                                                  Provider.of<ProductsProvider>(
                                                                  context)
                                                              .getrevVisible ==
                                                          false
                                                      ? Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 30.0)
                                                      : Icon(
                                                          Icons
                                                              .arrow_forward_ios,
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
                                            child: _getProduct.reviews.length ==
                                                    0
                                                ? Text('No Comment Yet ')
                                                : Column(
                                                    children: List.generate(
                                                        _getProduct.reviews
                                                            .length, (index) {
                                                      var items = _getProduct
                                                          .reviews[index];
                                                      DateTime now =
                                                          DateTime.parse(items
                                                              .createdAt
                                                              .toString());
                                                      String formattedTime =
                                                          DateFormat.yMMMEd()
                                                              .format(now);
                                                      return Card(
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RatingBar.builder(
                                                                unratedColor:
                                                                    Colors.grey,
                                                                itemSize: 20,
                                                                initialRating: double
                                                                    .parse(items
                                                                        .stars
                                                                        .toString()),
                                                                minRating: 1,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemCount: 5,
                                                                itemPadding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            2.0),
                                                                itemBuilder:
                                                                    (context,
                                                                            _) =>
                                                                        Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .amber,
                                                                ),
                                                                onRatingUpdate:
                                                                    (rating) {
                                                                  print(rating);
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              AutoSizeText(
                                                                items.comment
                                                                    .toString(),
                                                                minFontSize: 12,
                                                                maxFontSize: 14,
                                                                maxLines: 3,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Flexible(
                                                                    child:
                                                                        AutoSizeText(
                                                                      formattedTime
                                                                          .toString(),
                                                                      minFontSize:
                                                                          12,
                                                                      maxFontSize:
                                                                          14,
                                                                      maxLines:
                                                                          3,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10.0,
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        AutoSizeText(
                                                                      "By ${items.user.name}",
                                                                      minFontSize:
                                                                          12,
                                                                      maxFontSize:
                                                                          14,
                                                                      maxLines:
                                                                          3,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  )),
                                    // : SizedBox()
                                    // line(context),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: txtCommentController,
                                          maxLines: 8,
                                          decoration: InputDecoration(
                                            hintText: "Comment!",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        child: SmoothStarRating(
                                          rating: rating,
                                          size: 25,
                                          color: kBrandColor,
                                          borderColor: kBrandColor,
                                          starCount: 5,
                                          onRated: (value) {
                                            setState(() {
                                              rating = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              color: kBrandColor),
                                          margin: EdgeInsets.only(
                                              left: 1.25 *
                                                  SizeConfig.heightMultiplier,
                                              // 10.0,
                                              right: 1.25 *
                                                  SizeConfig.heightMultiplier,
                                              top: 5,
                                              //  5.0
                                              bottom: 10.0),
                                          child: TextButton(
                                              onPressed: () async {
                                                if (!await context
                                                    .read<ProductsProvider>()
                                                    .reviewProducts(
                                                        widget.productId,
                                                        txtCommentController
                                                            .text,
                                                        rating.round())) {
                                                  switch (context
                                                      .read<ProductsProvider>()
                                                      .reviewProductState) {
                                                    case ReviewProductState
                                                        .initial:
                                                    case ReviewProductState
                                                        .loading:
                                                    case ReviewProductState
                                                        .complete:
                                                    case ReviewProductState
                                                        .error:
                                                      return ScaffoldMessenger
                                                              .of(context)
                                                          .showSnackBar(displayMessage(
                                                              Provider.of<ProductsProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .commentError
                                                                  .toString()));
                                                  }
                                                } else {
                                                  productDetails();
                                                  txtCommentController.clear();
                                                }
                                              },
                                              child:
                                                  changeUserPassword(context))),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, bottom: 10.0, top: 10.0),
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

// ignore: missing_return
Widget changeUserPassword(BuildContext context) {
  switch (context.watch<ProductsProvider>().reviewProductState) {
    case ReviewProductState.initial:
      return AutoSizeText(
        'Add Comment',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case ReviewProductState.loading:
      return Row(children: [
        CupertinoActivityIndicator(),
        AutoSizeText(
          'Posting...',
          minFontSize: 10,
          maxFontSize: 12,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ]);
    case ReviewProductState.error:
      return AutoSizeText(
        'Add Comment',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case ReviewProductState.complete:
      return AutoSizeText(
        'Added',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
  }
}
