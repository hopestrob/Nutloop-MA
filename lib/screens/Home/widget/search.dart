import 'package:flutter/material.dart';
import 'package:nuthoop/provider/products_provider.dart';
import 'package:nuthoop/screens/Home/pages/productSearchREsult.dart';
import 'package:provider/provider.dart';
import '../../Auth/constants.dart';
// import '../filteredsearchresult.dart';

Row buildSearchRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SearchProductWidget(),
      // SizedBox(width: 10),
    ],
  );
}

class SearchProductWidget extends StatefulWidget {
  const SearchProductWidget({Key key, s}) : super(key: key);

  @override
  _SearchProductWidgetState createState() => _SearchProductWidgetState();
}

class _SearchProductWidgetState extends State<SearchProductWidget> {
  TextEditingController searchProduct = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onFieldSubmitted: (value) {
          Provider.of<ProductsProvider>(context, listen: false)
              .searchByproduct(value.trim());
          if (Provider.of<ProductsProvider>(context, listen: false)
                  .getProductFilter !=
              null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductnameSeachResult(productName: value.trim())));
          }
        },
        textInputAction: TextInputAction.go,
        controller: searchProduct,
        keyboardType: TextInputType.text,
        autofocus: false,
        style:
            new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        decoration: new InputDecoration(
            contentPadding:
                new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            hintText: "What would you like to buy today?",
            hintStyle: TextStyle(fontSize: 12.0, color: kBrandColor),
            // fillColor: Colors.grey,
            prefixIcon: IconButton(
                onPressed: () {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .searchByproduct(searchProduct.text.trim());
                  if (Provider.of<ProductsProvider>(context, listen: false)
                          .getProductFilter !=
                      null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductnameSeachResult(
                                productName: searchProduct.text.trim())));
                  }
                },
                icon: Icon(Icons.search, color: kBrandColor)),
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
