// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/category_model.dart';
// import 'package:nutloop_ecommerce/model/product_model.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';

import 'productBycategory.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {

 @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    // ignore: unused_element
    Future<List<CategoryModel>> getUserData() => ProductsProvider().getCategories();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
                  child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:40.0, bottom: 20.0),
                child: Center(child: Text('All Products', style: TextStyle(color: kBrandColor, fontSize: 20.0, fontWeight: FontWeight.bold)),),
              ),
              buildSearchRow(),
             SizedBox(height: size.height * 0.020),
                //    FutureBuilder(
                //  future: getUserData(),
                //      builder: (context, snapshot) {
                //        switch (snapshot.connectionState) {
                //   case ConnectionState.waiting:
                //     return Center(
                //       child: CupertinoActivityIndicator(
                //             radius: 12,
                //           ),
                //     );
                //     //  case ConnectionState.done:
                //     default:
                //     if (snapshot.hasData==null || snapshot.data == null)
                //       return Center( heightFactor: 2, child: Text('Try Again Later'));
                //     else if(snapshot.hasError )
                //         return Center( heightFactor: 2, child: Text('Try Again Later'));
                //     else
                //   return 
                   Consumer<ProductsProvider>(
                  builder: (context, cat, child) {
                            final categories = cat.getCategoy;
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                           physics: NeverScrollableScrollPhysics(),
                          itemCount: categories.length == null ? 0 : categories.length,
                          itemBuilder: (context, index) {
                            // print("this is category ${categories[index].id}");
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsByCategory(categoryName: categories[index].name, categoryId:categories[index].id.toString())));
                                },
                                 child: Container(
                                  height:  size.height > 412 ? size.height * 0.1500 : size.height * 0.2100,
                                  // height: MediaQuery.of(context).size.height / 7.5,
                                  margin: EdgeInsets.only(top:5.0, bottom: 20.0, right: 15.0, left: 15.0),
                                  padding: EdgeInsets.all(10.0),
                                   decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: categories[index].name == "Vegetables" ? productColor2
                                     : categories[index].name == "Fresh Fruits" ? productColor2 
                                     : categories[index].name == "Cereals & Grains" ? kBrandColor
                                     : categories[index].name == "Meat and Poultry" ? productColor2
                                     : categories[index].name == "Cooking Produce" ? kBrandColor  : kBrandColor,
                                     boxShadow: [
                                    BoxShadow(
                                      color: categories[index].name == "Vegetables" ? productColor2
                                     : categories[index].name == "Fresh Fruits" ? productColor2 
                                      : categories[index].name == "Cereals & Grains" ? kBrandColor
                                     : categories[index].name == "Meat and Poultry" ? productColor2
                                     : categories[index].name == "Cooking Produce" ? kBrandColor  : kBrandColor,
                                      spreadRadius: 5,
                                      blurRadius: 1.2,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ], 
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:size.width/1.6,
                                            child: Text(categories[index].name, overflow: TextOverflow.ellipsis, style: TextStyle(
                                              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold
                                            )),
                                          ),
                                          
                                          Container(
                                            width: size.width / 1.6,
                                             height: size.height * 0.0800,
                                            child: Text(categories[index].description, style: TextStyle(
                                              color: Colors.white, fontSize: 12.0,
                                             
                                            ), 
                                            // overflow: TextOverflow.ellipsis,
                                            
                                            ),
                                          ),
                                        ],
                                      ),
                                       Image.network(
                                         Api.imageUrl + categories[index].icon, height: 40, width: 40, color: Colors.white.withOpacity(.6)),
                                    //   Icon(
                                    //     Icons.categories[index].icon 
                                    //  : _category[index].categoryName == "Meat and Poultry" ? Icons.fastfood
                                    //  : _category[index].categoryName == "Cooking Produce" ?  Icons.emoji_food_beverage : Icons.fastfood, 
                                    //   color: Colors.white.withOpacity(.6), size: 80.0,),
                                    ],
                                  ),
                                ),
                              );
                          });
                           })
                    //  }
                    //   } )
          
            ]),
          ),
        ),
      ),
       );
  }

  Row buildSearchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchProductWidget(),
        SizedBox(width: 10),
      ],
    );
  }

  Row buildActionbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => {print('Hello')},
          child: CircleAvatar(
            radius: 25,
            backgroundColor: kPrimaryColor,
            child: Icon(
              Icons.person,
              size: 50.0,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hi Josh,',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
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
