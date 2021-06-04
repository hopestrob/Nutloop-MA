import 'package:flutter/material.dart';
import '../../../helper/config_size.dart';
import '../../Auth/constants.dart';
import 'package:provider/provider.dart';
import '../../Home/widget/search.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import '../../../model/unitModel.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final String title;
  Header({this.title});

    String selectedUnit;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<ProductsProvider>(context).getUnit();
    return Container(
      margin: EdgeInsets.only(
        //10.0 5.0
        left: 2.4307 * SizeConfig.widthMultiplier,
        right: 1.215 * SizeConfig.widthMultiplier,
      ),
      // width: 200,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                //30
                top: 3.76 * SizeConfig.heightMultiplier),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 2.4307 * SizeConfig.widthMultiplier,
                      ),
                      child: Icon(Icons.arrow_back_ios,
                          //30
                          size: 7.292 * SizeConfig.widthMultiplier,
                          color: greyColor2),
                    )),
                Container(
                  padding: EdgeInsets.only(
                      //20
                      left: 4.861 * SizeConfig.widthMultiplier),
                  width: MediaQuery.of(context).size.width / 2.0,
                  child: Text(this.title,
                      // textAlign: TextAlign.justify,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: kBrandColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
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
                                Provider.of<ProductsProvider>(context,
                                        listen: false)
                                    .measurementState(value);
                              },
                              items: Provider.of<ProductsProvider>(context)
                                  .getUnits
                                  .map((UnitModel map) {
                                return new DropdownMenuItem<String>(
                                  value: map.name,
                                  child: new Text(map.name,
                                      style:
                                          new TextStyle(color: Colors.black)),
                                );
                              }).toList())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.020),
          buildSearchRow(),
          SizedBox(height: size.height * 0.010),
        ],
      ),
    );
  }
}
