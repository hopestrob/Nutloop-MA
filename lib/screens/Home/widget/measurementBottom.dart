import 'package:flutter/material.dart';
import 'package:nuthoop/model/unitModel.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:provider/provider.dart';
import '../../../helper/config_size.dart';

void measurementBottomSheet(BuildContext context, String selectedUnit) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: IntrinsicHeight(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Flexible(
                        flex: 2,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Measurement Scare',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]),
                        )),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 1),
                            child: Text('Select Measurement Scare'),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                top: 10.0, left: 30.0, right: 30.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                    color: kBrandColor,
                                    style: BorderStyle.solid,
                                    width: 1.80)),
                            child: DropdownButtonHideUnderline(
                                child: new DropdownButton<String>(
                                    hint: Provider.of<ProductsProvider>(context)
                                                .getMeasurement
                                                .toString() ==
                                            null.toString()
                                        ? Text('Choose a measurement')
                                        : Text(Provider.of<ProductsProvider>(
                                                context)
                                            .getMeasurement
                                            .toString()),
                                    value: selectedUnit,
                                    isDense: true,
                                    onChanged: (value) {
                                      Provider.of<ProductsProvider>(context,
                                              listen: false)
                                          .measurementState(value);

                                      print(
                                          'this os the value ${Provider.of<ProductsProvider>(context, listen: false).getMeasurement.toString()}');
                                    },
                                    items:
                                        Provider.of<ProductsProvider>(context)
                                            .getUnits
                                            .map((UnitModel map) {
                                      return new DropdownMenuItem<String>(
                                        value: map.name,
                                        child: new Text(map.name,
                                            style: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 15.0)),
                                      );
                                    }).toList())),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 10.0,
                      ),
                    ),
                    Flexible(
                        flex: 1,
                        child: Container(
                          //300
                          width: 83.33 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              color: Color(0xff80C46D),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextButton(
                            onPressed: () async {
                              // Future.delayed(Duration(milliseconds: 1), () {
                              Navigator.pop(context);
                              // });
                            },
                            child: Text(
                              'Save Changes',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 5.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
