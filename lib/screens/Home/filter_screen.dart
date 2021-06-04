import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/category_model.dart';
import 'package:nutloop_ecommerce/provider/filter_provider.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';

import 'filteredsearchresult.dart';
import 'widget/header.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final myController = TextEditingController();

  Api api = new Api();
  bool selected = false;
  List<CategoryModel> categories = [];
  var userStatus = <bool>[];

  Future<List<CategoryModel>> getCategories() async {
    try {
      var response = await api.getCategory();
      var result = json.decode(response.body);
      //  var list = result['data'] as List;
      print(result['data']);
      result['data'].forEach((data) {
        var category = CategoryModel();
        category.id = data['id'];
        category.name = data['name'];
        if (mounted) {
          setState(() {
            categories.add(category);
            userStatus.add(false);
          });
        }
      });

      return categories;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  int categoryId;
  int rating;
  int freshness;
  final startController = TextEditingController();
  final endController = TextEditingController();

  double _starValue = 10;
  double _endValue = 80;
  double minValue = 0.0;
  double maxValue = 100.0;

  List<String> _texts = [
    "1",
    "2",
  ];

  var _isChecked = <bool>[];
  @override
  void initState() {
    _isChecked = List<bool>.filled(_texts.length, false);
    getCategories();
    startController.addListener(_setStartValue);
    endController.addListener(_setEndValue);
    super.initState();
  }

  @override
  void dispose() {
    getCategories();
    // myController.dispose();
    startController.dispose();
    endController.dispose();
    super.dispose();
  }

  _setStartValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _starValue = double.parse(startController.text).roundToDouble();
      });
    }
    print("Second text field: ${startController.text}");
  }

  _setEndValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _endValue = double.parse(endController.text).roundToDouble();
      });
    }
    print("Second text field: ${endController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: header(context, "Filters")),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Categories'),
                ),
                Column(
                  children: List.generate(
                      categories == null ? 0 : categories.length, (i) {
                    return ListTile(
                      title: Text('${categories[i].name}'),
                      leading: Theme(
                        data: ThemeData(unselectedWidgetColor: kBrandColor),
                        child: Checkbox(
                            activeColor: kBrandColor,
                            value: userStatus[i],
                            onChanged: (val) {
                              setState(() {
                                userStatus[i] = !userStatus[i];
                                val = userStatus[i];
                                categoryId = categories[i].id;
                                print(categoryId);
                              });
                            }),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Freshness'),
                ),
                Container(
                    child: Column(
                        children: List.generate(
                            _texts == null ? 0 : _texts.length, (i) {
                  return ListTile(
                    title: Text('${_texts[i]} day old'),
                    leading: Theme(
                      data: ThemeData(unselectedWidgetColor: kBrandColor),
                      child: Checkbox(
                          activeColor: kBrandColor,
                          value: _isChecked[i],
                          onChanged: (val) {
                            setState(() {
                              _isChecked[i] = !_isChecked[i];
                              freshness = int.parse(_texts[i]);
                              // _isChecked[i] = val;
                            });
                          }),
                    ),
                  );
                }))),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Price'),
                ),
                RangeSlider(
                  activeColor: kBrandColor,
                  values: RangeValues(_starValue, _endValue),
                  min: minValue,
                  max: maxValue,
                  onChanged: (values) {
                    setState(() {
                      _starValue = values.start.roundToDouble();
                      _endValue = values.end.roundToDouble();
                      startController.text =
                          values.start.roundToDouble().toString();
                      endController.text =
                          values.end.roundToDouble().toString();
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Min'),
                          Container(
                            width: 150.0,
                            margin: EdgeInsets.only(top: 5.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: startController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '0.0',
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: greyColor4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Max'),
                          Container(
                            width: 150.0,
                            margin: EdgeInsets.only(top: 5.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: endController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: '0.0',
                                hintStyle: TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.all(16),
                                fillColor: greyColor4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Rating'),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setFiveRating('5');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .fiveRatVal);
                  },
                  child: CheckBoxRatingFilter(
                    starValues: 5,
                    icon: Provider.of<FilterProducts>(context).getFiveRating ==
                            true
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setFourRating('4');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .fourRatVal);
                  },
                  child: CheckBoxRatingFilter(
                    starValues: 4,
                    icon: Provider.of<FilterProducts>(context).getFourRating ==
                            true
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setThreeRating('3');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .threeRatVal);
                  },
                  child: CheckBoxRatingFilter(
                    starValues: 3,
                    icon: Provider.of<FilterProducts>(context).getThreeRating ==
                            true
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setTwoRating('2');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .twoRatVal);
                  },
                  child: CheckBoxRatingFilter(
                      starValues: 2,
                      icon: Provider.of<FilterProducts>(context).getTwoRating ==
                              true
                          ? Icons.check
                          : Icons.check_box_outline_blank),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setOneRating('1');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .oneRatVal);
                  },
                  child: CheckBoxRatingFilter(
                    starValues: 1,
                    icon: Provider.of<FilterProducts>(context).getOneRating ==
                            true
                        ? Icons.check
                        : Icons.check_box_outline_blank,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Provider.of<FilterProducts>(context, listen: false)
                        .setNoRating('0');
                    print(Provider.of<FilterProducts>(context, listen: false)
                        .noRatVal);
                  },
                  child: CheckBoxRatingFilter(
                    starValues: 0,
                    icon:
                        Provider.of<FilterProducts>(context).getNoRating == true
                            ? Icons.check
                            : Icons.check_box_outline_blank,
                  ),
                ),
                Container(
                  height: 70.0,
                  width: 500,
                  margin: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                      onPressed: () async {
                        // print(double.parse(startController.text.trim()).round().toInt());
                        Provider.of<ProductsProvider>(context, listen: false)
                            .searchByFilter(
                                categoryId,
                                freshness,
                                startController.text.trim().isEmpty
                                    ? 0
                                    : double.parse(startController.text.trim())
                                        .toInt(),
                                endController.text.trim().isEmpty
                                    ? 0
                                    : double.parse(endController.text.trim())
                                        .toInt(),
                                Provider.of<FilterProducts>(context, listen: false)
                                            .oneRatVal ==
                                        "1"
                                    ? 1
                                    : Provider.of<FilterProducts>(context, listen: false)
                                                .twoRatVal ==
                                            "2"
                                        ? 2
                                        : Provider.of<FilterProducts>(context, listen: false)
                                                    .threeRatVal ==
                                                "3"
                                            ? 3
                                            : Provider.of<FilterProducts>(
                                                            context,
                                                            listen: false)
                                                        .fourRatVal ==
                                                    "4"
                                                ? 4
                                                : Provider.of<FilterProducts>(
                                                                context,
                                                                listen: false)
                                                            .fiveRatVal ==
                                                        "5"
                                                    ? 5
                                                    : 0);
                        if (Provider.of<ProductsProvider>(context,
                                    listen: false)
                                .getProductFilter !=
                            null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchFilterResult(
                                        catId: categoryId,
                                        freshness: freshness,
                                        minPrice: startController.text
                                                .trim()
                                                .isEmpty
                                            ? 0
                                            : double.parse(
                                                    startController.text.trim())
                                                .round()
                                                .toInt(),
                                        maxPrice: endController.text
                                                .trim()
                                                .isEmpty
                                            ? 0
                                            : double.parse(
                                                    endController.text.trim())
                                                .round()
                                                .toInt(),
                                        rating: Provider.of<FilterProducts>(
                                                        context,
                                                        listen: false)
                                                    .oneRatVal ==
                                                "1"
                                            ? 1
                                            : Provider.of<FilterProducts>(
                                                            context,
                                                            listen: false)
                                                        .twoRatVal ==
                                                    "2"
                                                ? 2
                                                : Provider.of<FilterProducts>(
                                                                context,
                                                                listen: false)
                                                            .threeRatVal ==
                                                        "3"
                                                    ? 3
                                                    : Provider.of<FilterProducts>(
                                                                    context,
                                                                    listen: false)
                                                                .fourRatVal ==
                                                            "4"
                                                        ? 4
                                                        : Provider.of<FilterProducts>(context, listen: false).fiveRatVal == "5"
                                                            ? 5
                                                            : 0,
                                      )));
                        }
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  height: 70.0,
                  width: 500,
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TextButton(
                      onPressed: () async {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckBoxRatingFilter extends StatelessWidget {
  final int starValues;
  final IconData icon;
  CheckBoxRatingFilter({this.starValues, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.0),
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 30.0, top: 10.0, bottom: 10.0),
              child: Icon(
                icon,
                size: 25.0,
                color: kBrandColor,
              )),
        ),
        starValues == 5
            ? Row(children: [
                Icon(Icons.star, color: productColor2),
                Icon(Icons.star, color: productColor2),
                Icon(Icons.star, color: productColor2),
                Icon(Icons.star, color: productColor2),
                Icon(Icons.star, color: productColor2)
              ])
            : starValues == 4
                ? Row(
                    children: [
                      Icon(Icons.star, color: productColor2),
                      Icon(Icons.star, color: productColor2),
                      Icon(Icons.star, color: productColor2),
                      Icon(Icons.star, color: productColor2),
                      Icon(Icons.star_border),
                    ],
                  )
                : starValues == 3
                    ? Row(
                        children: [
                          Icon(Icons.star, color: productColor2),
                          Icon(Icons.star, color: productColor2),
                          Icon(Icons.star, color: productColor2),
                          Icon(Icons.star_border),
                          Icon(Icons.star_border),
                        ],
                      )
                    : starValues == 2
                        ? Row(
                            children: [
                              Icon(Icons.star, color: productColor2),
                              Icon(Icons.star, color: productColor2),
                              Icon(Icons.star_border),
                              Icon(Icons.star_border),
                              Icon(Icons.star_border),
                            ],
                          )
                        : starValues == 1
                            ? Row(
                                children: [
                                  Icon(Icons.star, color: productColor2),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                  Icon(Icons.star_border),
                                ],
                              )
      ],
    );
  }
}
