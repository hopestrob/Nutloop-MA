import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/model/faqModel.dart';
import 'package:nutloop_ecommerce/provider/products_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/header.dart';
import 'package:provider/provider.dart';

// import 'addCard.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Provider.of<List<FaqModel>>(context);
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
                      builder: (_, faqList, child) => ListView.builder(
                        key: Key('builder ${selected.toString()}'), //attention

                        padding: EdgeInsets.only(
                            left: 13.0, right: 13.0, bottom: 25.0),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: faqList.getFaq.length,
                        itemBuilder: (context, index) {
                          return Column(children: <Widget>[
                            Divider(
                              height: 17.0,
                              color: Colors.white,
                            ),
                            ExpansionTile(
                                key: Key(index.toString()), //attention
                                initiallyExpanded:
                                    index == selected, //attention
                                title: Text('${faqList.getFaq[index].question}',
                                    style: TextStyle(
                                        color: kBrandColor,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold)),
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.all(25.0),
                                      child: Text(
                                        '${faqList.getFaq[index].answer}',
                                      ))
                                ],
                                onExpansionChanged: ((newState) {
                                  if (newState)
                                    setState(() {
                                      Duration(seconds: 20000);
                                      selected = index;
                                    });
                                  else
                                    setState(() {
                                      selected = -1;
                                    });
                                })),
                          ]);
                        },
                      ),
                    ))))
      ]),
    ));
  }
}
