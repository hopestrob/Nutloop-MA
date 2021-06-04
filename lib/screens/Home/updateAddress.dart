import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:nutloop_ecommerce/screens/Auth/widget/textfield.dart';
import 'package:provider/provider.dart';

class UpdateDeliveryAddress extends StatefulWidget {
  final int addressId;
  UpdateDeliveryAddress({this.addressId});

  @override
  _UpdateDeliveryAddressState createState() => _UpdateDeliveryAddressState();
}

class _UpdateDeliveryAddressState extends State<UpdateDeliveryAddress> {
  TextEditingController txtaddress = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController deliveryInsController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _value = false;
  bool _value2 = false;
  @override
  void initState() {
    super.initState();
    //   firstNameController.text =
    //       Provider.of<Authentication>(context, listen: false)
    //           .getAddressBook
    //           .firstName
    //           .toString();
    //   lastNameController.text =
    //       Provider.of<Authentication>(context, listen: false)
    //           .getAddressBook
    //           .lastName
    //           .toString();
    //   phoneController.text = Provider.of<Authentication>(context, listen: false)
    //       .getAddressBook
    //       .phoneNumber
    //       .toString();
    //   mobileController.text = Provider.of<Authentication>(context, listen: false).getAddressBook.mobileNumber.toString();
    //   houseNoController.text = Provider.of<Authentication>(context, listen: false)
    //       .getAddressBook
    //       .houseNo
    //       .toString();
    //   streetController.text = Provider.of<Authentication>(context, listen: false)
    //       .getAddressBook
    //       .street
    //       .toString();
    //   areaController.text = Provider.of<Authentication>(context, listen: false)
    //       .getAddressBook
    //       .area
    //       .toString();
    //   cityController.text = Provider.of<Authentication>(context, listen: false)
    //       .getAddressBook
    //       .city
    //       .toString();
    //   deliveryInsController.text =
    //       Provider.of<Authentication>(context, listen: false)
    //           .getAddressBook
    //           .deliveryInstructions
    //           .toString();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Authentication>(context, listen: false).getAddressBookList();
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor4,
        key: _scaffoldKey,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Card(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios,
                          size: 30, color: greyColor2)),
                  // SizedBox(width: 100.0),
                  Container(
                    margin: EdgeInsets.only(
                        right: size.height > 412 ? 120.0 : 350.0),
                    child: Text('Delivery Address',
                        style: TextStyle(
                            color: kBrandColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
          // Text('my Card'),

          Consumer<Authentication>(
            builder: (context, authUser, child) => Card(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                height:
                    size.height > 412 ? size.height * 1.1 : size.height * 2.2,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: firstNameController,
                      hitText: "First Name",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: lastNameController,
                      hitText: "Last Name",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      hitText: "Phone Number",
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        // keyboardType: keyboardType,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: houseNoController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.only(bottom: 20.0),
                          labelText: "House No.",
                          labelStyle:
                              TextStyle(color: kPrimaryColor, fontSize: 15),
                        ),
                      ),
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      hitText: "Mobile Number *",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.streetAddress,
                      controller: streetController,
                      hitText: "Street",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: areaController,
                      hitText: "Area",
                    ),
                    CustomTextField(
                      keyboardType: TextInputType.text,
                      controller: cityController,
                      hitText: "City",
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        // initialValue:authUser.getAddressBook.deliveryInstructions.toString(),
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.black,
                          height: 1.0,
                        ),
                        controller: deliveryInsController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          contentPadding: EdgeInsets.only(bottom: 20.0),
                          labelText: 'Delivery Instructions',
                          labelStyle:
                              TextStyle(color: kPrimaryColor, fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text('Delivery Options',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold))),
                InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle, color: kBrandColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value
                              ? Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: kBrandColor,
                                )
                              : Icon(
                                  Icons.radio_button_off,
                                  size: 30.0,
                                  color: kBrandColor,
                                ),
                        ),
                      ),
                      Text('Set as default Delivery Address')
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _value2 = !_value2;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(15.0),
                        // decoration: BoxDecoration(
                        //     shape: BoxShape.circle, color: kBrandColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: _value2
                              ? Icon(
                                  Icons.check,
                                  size: 30.0,
                                  color: kBrandColor,
                                )
                              : Icon(
                                  Icons.radio_button_off_outlined,
                                  size: 30.0,
                                  color: kBrandColor,
                                ),
                        ),
                      ),
                      Text('Deliver Once to this address')
                    ],
                  ),
                ),
              ],
            ),
          ),

          Consumer<Authentication>(
            builder: (context, authUserSave, child) => Container(
              margin: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: kBrandColor, borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                  onPressed: () {
                    // print(authUserSave.getAddressBook.street);
                    Provider.of<CartProvider>(context, listen: false)
                        .saveAddress(streetController.text.trim());
                    authUserSave.updateAddressBook(
                        1,
                        // Provider.of<Authentication>(context, listen: false).getAddressBook.id,
                        firstNameController.text,
                        lastNameController.text,
                        phoneController.text,
                        mobileController.text,
                        houseNoController.text,
                        streetController.text,
                        cityController.text,
                        areaController.text,
                        deliveryInsController.text);
                    if (authUserSave.getAddressBook != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Error Processsing Your Order')));
                      Navigator.pop(context);
                    } else {
                      print('Error processing the form');
                    }
                  },
                  child: Text(
                    'Deliver to this Address',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          SizedBox(
            height: 120.0,
          )
        ]))));
  }

  String validateAddress(String value, String hitText) {
    if (!(value.length > 3) && value.isNotEmpty) {
      return "$hitText should contain less than 3 characters";
    }
    return null;
  }
}
