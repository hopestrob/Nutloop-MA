import 'package:flutter/material.dart';
// import 'package:nutloop_ecommerce/model/addressBook.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/helper/config_size.dart';
import 'package:nutloop_ecommerce/screens/Home/addDeliveryAddress.dart';
import 'package:nutloop_ecommerce/screens/Home/updateAddress.dart';
import 'package:nutloop_ecommerce/screens/Home/widget/progressdialog.dart';
import 'package:provider/provider.dart';
import '../Home/widget/header.dart';

class AddressBookScreen extends StatefulWidget {
  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  // @override
  // void didChangeDependencies() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<Authentication>(context, listen: false).getAddressBookList();
  //   });
  //   super.didChangeDependencies();
  // }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<Authentication>(context, listen: false).getAddressBookList();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final addresslist = Provider.of<List<AddressBook>>(context);
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
                                      AddDeliveryAddress()));
                        },
                        child: Text('Add New Address',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 10),
            Expanded(
              child: FutureProvider(
                create: (_) =>
                    Provider.of<Authentication>(context, listen: false)
                        .getAddressBookList(),
                child: Container(
                    color: greyColor5,
                    child: Consumer<Authentication>(
                        builder: (context, addresslist, _) {
                      return addresslist.getAddressBook.length == 0
                          ? Center(child: CircularProgressIndicator())
                          : addresslist.getAddressBook == null
                              ? Container(
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
                                                  AddDeliveryAddress()));
                                    },
                                    child: Text('Add New Address',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: addresslist.getAddressBook?.length,
                                  itemBuilder: (context, index) {
                                    // print(
                                    //     'this is the addressbooklength ${addresslist?.length}');
                                    final addressDetail =
                                        addresslist.getAddressBook[index];
                                    return Card(
                                      // margin: EdgeInsets.all(15.0),
                                      child: Container(
                                        height: 120.0,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'ADDRESS:',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                  width: 180.0,
                                                  height: 60,
                                                  child: SingleChildScrollView(
                                                      physics:
                                                          ClampingScrollPhysics(),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            addressDetail
                                                                .street,
                                                            // 'teh d khs hd bsh cjhs hks v vd kHave you ever fully just gave in to the temptation and read your horoscope',
                                                            // overflow: TextOverflow.ellipsis,
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style: TextStyle(
                                                              fontSize: 1.98 *
                                                                  SizeConfig
                                                                      .heightMultiplier,
                                                              // 14.0
                                                            )),
                                                      )),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: IconButton(
                                                      onPressed: () {
                                                        int textToSendBack =
                                                            addressDetail.id;
                                                        Navigator.pop(context,
                                                            textToSendBack);
                                                      },
                                                      icon: Icon(Icons
                                                          .radio_button_off)),
                                                ),
                                              ],
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.blue[400],
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdateDeliveryAddress(
                                                                    addressId:
                                                                        addressDetail
                                                                            .id,
                                                                  )));
                                                    },
                                                    child: Text('Change',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: Colors.red[400],
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 5),
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
                                                                listen: false)
                                                            .deleteAddressBook(
                                                                addressDetail
                                                                    .id);
                                                      });
                                                    },
                                                    child: Text('Delete',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
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
              ),
            )
          ]),
        ));
  }
}
