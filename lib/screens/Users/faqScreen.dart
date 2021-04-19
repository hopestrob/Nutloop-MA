import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/header.dart';
import 'package:provider/provider.dart';

import 'addCard.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    //  Provider.of<ProductsProvider>(context, listen: false).getFaqies();
    // print(faqList);
    return Scaffold(
        body: SafeArea(
      bottom: false,
      top: false,
      left: false,
      right: false,
      child: Column(children: [
        SizedBox(height: 10),
        Container(child: header(context, "FAQs")),
        SizedBox(height: 10),
        Expanded(
            child: Container(
                color: greyColor5,
                child: Container(
                    margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: Consumer<ProductsProvider>(
                        builder: (_, faqList, child) => ListView(
                              children:
                                  List.generate(faqList.getFaq.length, (index) {
                                return Column(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(faqList.getFaq[index].question,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                                InkWell(
                                             onTap: (){
                                                Provider.of<ProductsProvider>(context, listen: false).togglefaqRev(
                                                  faqList.getFaq[index].id
                                                );
                                             },
                                             child:  Provider.of<ProductsProvider>(context).faqRev == false ? 
                                             Icon(Icons.add, size: 30.0,):Icon(Icons.remove,  size: 20.0)
                                             
                                             )
                                      ],
                                    ),
                                    Provider.of<ProductsProvider>(context)
                                                .faqRev ==
                                            false
                                        ? SizedBox()
                                        : faqList
                                                    .getFaq[index].defaultOpen == 0 ? SizedBox(): Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(faqList
                                                    .getFaq[index].answer),
                                                SizedBox(
                                                  height: 20.0,
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.0,),
                                    line(context),
                                    SizedBox(height: 20.0,)
                                  ],
                                );
                                // Text(faqList.getFaq[index].question);
                              }),
                            )))))
      ]),
    ));
  }
}
