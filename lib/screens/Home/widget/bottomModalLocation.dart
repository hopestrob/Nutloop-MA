import 'package:flutter/material.dart';
import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:provider/provider.dart';

class BottomSheetModel extends StatefulWidget {
  @override
  _BottomSheetModelState createState() => _BottomSheetModelState();
}

class _BottomSheetModelState extends State<BottomSheetModel> {
  // ignore: override_on_non_overriding_member

  var currentSelectedValue, currentSelectedValueArea, currentSelectedValueAgent;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50.0))),
      height: size.height,
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Consumer<CartProvider>(
          builder: (_, checkOut, child) => ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    'Express Delivery',
                    style: TextStyle(color: kBrandColor, fontSize: 24.0),
                  )),
                  Container(
                      margin:
                          EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                      child: Text(
                          'Set State, ${currentSelectedValue == null ? " " : currentSelectedValue}')),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                    padding: EdgeInsets.all(10.0),
                    width: size.width / 1.1,
                    height: size.height > 412
                        ? size.height * 0.0699
                        : size.height * 0.1399,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                            color: kBrandColor,
                            style: BorderStyle.solid,
                            width: 1.80)),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: checkOut.expressPickUpPlace == null
                          ? Text("Choose a Location")
                          : Text(checkOut.expressPickUpPlace.toString()),
                      // value: currentSelectedValue == null ? "Choose a Location" : currentSelectedValue,
                      items: <String>[
                        'Abuja',
                        'Lagos',
                        'Rivers',
                        'Owerri',
                        'Warri',
                        'Asaba',
                        'Onitsha',
                        'Jos'
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value == null ? "Choose a Location" : value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        checkOut.expressPickUpVenue(value);
                        setState(() {
                          currentSelectedValue = checkOut.expressPickUpPlace;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                      child: Text('Set closet Area to you')),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
                    padding: EdgeInsets.all(10.0),
                    width: size.width / 1.1,
                    height: size.height > 412
                        ? size.height * 0.0699
                        : size.height * 0.1399,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                            color: kBrandColor,
                            style: BorderStyle.solid,
                            width: 1.80)),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: checkOut.expressPickUpPlaceArea == null
                          ? Text("Choose a Area")
                          : Text(checkOut.expressPickUpPlaceArea.toString()),
                      // value: currentSelectedValue == null ? "Choose a Location" : currentSelectedValue,
                      items: <String>[
                        'Silas Christy',
                        'Paul Christy',
                        'Peter Christy',
                        'Burn James',
                        'Peter Anthony',
                        'John Mola',
                      ].map((String values) {
                        return new DropdownMenuItem<String>(
                          value: values == null ? "Choose a Area" : values,
                          child: new Text(values),
                        );
                      }).toList(),
                      onChanged: (values) {
                        checkOut.expressPickUpVenueArea(values);
                        setState(() {
                          currentSelectedValueArea =
                              checkOut.expressPickUpPlaceArea;
                        });
                      },
                    ),
                  ),
                  Container(
                      margin:
                          EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                      child: Text('Available OSP')),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, left: 30.0, right: 30.0),
                    padding: EdgeInsets.all(10.0),
                    width: size.width / 1.1,
                    height: size.height > 412
                        ? size.height * 0.0699
                        : size.height * 0.1399,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                            color: kBrandColor,
                            style: BorderStyle.solid,
                            width: 1.80)),
                    child: DropdownButton<String>(
                      underline: SizedBox(),
                      isExpanded: true,
                      hint: checkOut.expressPickUpPlaceAgent == null
                          ? Text("Available OSP")
                          : Text(checkOut.expressPickUpPlaceAgent.toString()),
                      // value: currentSelectedValue == null ? "Choose a Location" : currentSelectedValue,
                      items: <String>[
                        '23 Peace Street',
                        '25 Peace Street',
                        '26 Peace Street',
                        '27 Peace Street',
                        '28 Peace Street',
                        '29 Peace Street',
                        '30 Peace Street',
                        '31 Peace Street'
                      ].map((String values) {
                        return new DropdownMenuItem<String>(
                          value: values == null ? "Choose a Area" : values,
                          child: new Text(values),
                        );
                      }).toList(),
                      onChanged: (values) {
                        checkOut.expressPickUpVenueAgent(values);
                        setState(() {
                          currentSelectedValueAgent =
                              checkOut.expressPickUpPlaceAgent;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
                    padding: EdgeInsets.all(10.0),
                    width: size.width > 412 ? size.width * 1.8 : size.width * 2,
                    decoration: BoxDecoration(
                        color: kBrandColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: TextButton(
                      onPressed: () {
                        checkOut.getExpressPickUpVenue(currentSelectedValue);
                        print("check address");
                        print(checkOut.getExpressPickUpAddress);
                        Navigator.pop(
                            context, checkOut.getExpressPickUpAddress);
                      },
                      child: Text(
                        'Save Changes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
