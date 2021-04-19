import 'package:flutter/material.dart';
import '../../Auth/constants.dart';

Row buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchProductWidget(),
        // SizedBox(width: 10),

      ],
    );
  }
class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({Key key, s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onTap: () {
          print('Search tapped');
        },
        keyboardType: TextInputType.text,
        autofocus: false,
        style:
            new TextStyle(fontWeight: FontWeight.normal, color: greyColor4),
        decoration: new InputDecoration(
            contentPadding:
                new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            labelText: "What would you like to buy today?",
            labelStyle: TextStyle(fontSize: 12.0),
            fillColor: greyColor5,
            prefixIcon: Icon(Icons.search, color: kBrandColor),
            // border: new OutlineInputBorder(
            //     borderRadius: new BorderRadius.all(Radius.circular(50.0)), gapPadding: 12),
            enabledBorder: InputBorder.none,
                    border: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
            //  focusedBorder:OutlineInputBorder(
            // borderSide: const BorderSide(color: kBrandColor, width: 2.0),
          //   borderRadius: BorderRadius.circular(25.0),
          // ),
            filled: true),
        validator: (val) {
          if (val.length == 0) {
            return "Search field cannot be empty";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
