import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/provider/auth_provider.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/helper/config_size.dart';
import 'package:nuthoop/screens/Home/widget/progressdialog.dart';
import 'package:nuthoop/screens/Users/updateAddress.dart';
import 'package:provider/provider.dart';

import 'addDeliveryAddress.dart';
// import '../Home/widget/header.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  // Future<List<AddressBook>> future;

  @override
  void didChangeDependencies() {
    Provider.of<Authentication>(context, listen: false)
        .getAddressBookList(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Container(
                padding: EdgeInsets.only(top: 8.0),
                margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios,
                            size: 30, color: greyColor2)),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width / 3.5,
                    // ),
                    Text(
                      'Address Book',
                      style: TextStyle(
                          color: kBrandColor, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.all(5.0),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.green[400],
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      // AddressBook()
                                      AddDeliveryAddress())).then((_) => {
                                Provider.of<Authentication>(context,
                                        listen: false)
                                    .getAddressBookList(context)
                              });
                        },
                        child: Text('Add New Address',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                  color: greyColor5,
                  child: Consumer<Authentication>(builder: (_, address, child) {
                    return address.getAddressBook == null
                        ? Center(
                            child: CupertinoActivityIndicator(
                            radius: 12,
                          ))
                        : address.getAddressBook.isEmpty
                            ? Center(child: Text('No address yet'))
                            : address.getAddressBook.length == 0
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Addressbook is Empty',
                                        style: TextStyle(fontSize: 20.0),
                                      ),

                                      // SizedBox(height: size.height * 0.150),
                                      Container(
                                        margin: EdgeInsets.all(
                                            5.0 * SizeConfig.widthMultiplier),
                                        width: 95 * SizeConfig.widthMultiplier,
                                        padding: EdgeInsets.all(10.0),
                                        // width: size.width / 1.2,
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            // AddressBook()
                                                            AddDeliveryAddress()))
                                                .then((_) => {
                                                      Provider.of<Authentication>(
                                                              context,
                                                              listen: false)
                                                          .getAddressBookList(
                                                              context)
                                                    });
                                          },
                                          child: Text(
                                            'Add Address',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : address.getAddressBook.length == null
                                    ? Container(
                                        margin: EdgeInsets.all(5.0),
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: Colors.green[400],
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        // AddressBook()
                                                        AddDeliveryAddress()));
                                          },
                                          child: Text('Add New Address',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount:
                                            address.getAddressBook.length,
                                        itemBuilder: (context, index) {
                                          final addressDetail =
                                              address.getAddressBook[index];
                                          return Card(
                                            // margin: EdgeInsets.all(15.0),
                                            child: Container(
                                              height: 90.0,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'ADDRESS:',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 180.0,
                                                          height: 60,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0,
                                                                    left: 8.0,
                                                                    top: 8.0),
                                                            child: AutoSizeText(
                                                              '${addressDetail.houseNo} ${addressDetail.street} ${addressDetail.city}  ${addressDetail.area}',
                                                              minFontSize: 10,
                                                              maxFontSize: 12,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: IconButton(
                                                              onPressed: () {
                                                                int textToSendBack =
                                                                    addressDetail
                                                                        .id;
                                                                Navigator.pop(
                                                                    context,
                                                                    textToSendBack);
                                                              },
                                                              icon: Icon(Icons
                                                                  .radio_button_off)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // ListTile(
                                                  //   contentPadding:
                                                  //       EdgeInsets.only(left: 15.0),
                                                  //   leading: Text('Address'),
                                                  //   title: Container(
                                                  //     width: 120,
                                                  //     height: 60,
                                                  //     child: SingleChildScrollView(
                                                  //         physics:
                                                  //             ClampingScrollPhysics(),
                                                  //         child: Text(
                                                  //             addressDetail.street,
                                                  //             // 'teh d khs hd bsh cjhs hks v vd kHave you ever fully just gave in to the temptation and read your horoscope',
                                                  //             // overflow: TextOverflow.ellipsis,
                                                  //             // softWrap: true,
                                                  //             style: TextStyle(
                                                  //               fontSize: 1.98 *
                                                  //                   SizeConfig
                                                  //                       .heightMultiplier,
                                                  //               // 14.0
                                                  //             ))),
                                                  //   ),
                                                  //   trailing: Padding(
                                                  //     padding:
                                                  //         const EdgeInsets.all(15.0),
                                                  //     child: IconButton(
                                                  //         onPressed: () {
                                                  //           int textToSendBack =
                                                  //               addressDetail.id;
                                                  //           Navigator.pop(context,
                                                  //               textToSendBack);
                                                  //         },
                                                  //         icon: Icon(Icons
                                                  //             .radio_button_off)),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(height: 5.0),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(5.0),
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          color:
                                                              Colors.blue[400],
                                                        ),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        UpdateDeliveryAddress(
                                                                          addressId:
                                                                              addressDetail.id,
                                                                        ))).then(
                                                                (_) => {
                                                                      Provider.of<Authentication>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .getAddressBookList(
                                                                              context)
                                                                    });
                                                          },
                                                          child: Text('Change',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(5.0),
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                          color:
                                                              Colors.red[400],
                                                        ),
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  Future.delayed(
                                                                      Duration(
                                                                          seconds:
                                                                              8),
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                  return ProgressDialog(
                                                                    message:
                                                                        "Please Wait..",
                                                                  );
                                                                }).then((_) {
                                                              // async{
                                                              //  bool suc = await
                                                              Provider.of<Authentication>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .deleteAddressBook(
                                                                      addressDetail
                                                                          .id)
                                                                  .then(
                                                                      (_) => {
                                                                            Provider.of<Authentication>(context, listen: false).getAddressBookList(context)
                                                                          });
                                                            });
                                                          },
                                                          child: Text('Delete',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                  })),
            )
          ]),
        ));
  }
}
