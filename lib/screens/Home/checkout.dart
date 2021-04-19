import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/provider/auth_provider.dart';
import 'package:nutloop_ecommerce/provider/cart.dart';
import 'package:nutloop_ecommerce/screens/Auth/constants.dart';
import 'package:provider/provider.dart';

import 'addDeliveryAddress.dart';
import 'checkOutAddCard.dart';
import 'successfulOrder.dart';
import 'widget/bottomModalLocation.dart';
import 'package:nutloop_ecommerce/model/cartModel.dart';

class CheckOutPage extends StatefulWidget {
  final int cartId,productid,productUnit,productQuantity;
  final List<CartModel> products;

  CheckOutPage({this.cartId, this.products, this.productid, this.productUnit, this.productQuantity});

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currentSelectedValue;
  @override
  Widget build(BuildContext context) {
      Provider.of<Authentication>(context, listen: false).getAddressBookDetail();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: greyColor4,
        key: _scaffoldKey,
        body: SafeArea(
            child: Container(
                // margin: const EdgeInsets.all(10.0),
                // padding: const EdgeInsets.all(8.0),
                child: ListView(children: <Widget>[
          Card(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 10.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios,
                          size: 30, color: greyColor2)),
                          SizedBox(width: 100.0),
                  Center(
                    child: Text('Checkout',
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
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, bottom: 20.0),
                          child: Text('My Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                          child: Text('View All',style: TextStyle(color: kBrandColor, fontSize: 16.0)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100.0,
                    width: 220.0,
                    padding: EdgeInsets.all(8.0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: new List.generate(this.widget.products.length, (index) {
                        return Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(100.0)),
                            // child: Image.network(this.widget.products[index].imageUrl)
                                );
                      }).toList(),
                    ),
                  ),

                ],
              ),
            ),
          ),

          Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                 
                  children: [
                   Provider.of<Cart>(context).getAddress != null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                            ),
                            InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddDeliveryAddress()));
                        },
                        child: Row(
                          children: [
                        Container(
                                margin: EdgeInsets.all(15.0),
                                padding: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(.1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30.0)),
                                    border: Border.all(color: kBrandColor, width: 2)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0, top: 3, bottom: 3),
                                    child: Text(
                                      'Change Address',
                                      style: TextStyle(color: kBrandColor),
                                    )))
                          ],
                        ),
                  ),
                  
                          ],
                        ),
                         Provider.of<Cart>(context).getAddress == null ? SizedBox(): Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Provider.of<Cart>(context, listen: false).getAddress, style: TextStyle(fontSize: 16.0),),
                  ),
             
                  //   Consumer<Authentication>(
                  // builder: (_, authUser, child) => Text(authUser.getAddressBook.street.toString())),
                  SizedBox(height: 20.0),
                     ],
                   ):Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        ),
                     InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddDeliveryAddress()));
                    },
                    child: Row(
                      children: [
                    Container(
                            margin: EdgeInsets.all(15.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                border: Border.all(color: kBrandColor, width: 2)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 3, bottom: 3),
                                child: Text(
                                  'Add Delivery Address',
                                  style: TextStyle(color: kBrandColor),
                                )))
                      ],
                    ),
                  ),

                 
                
                      ],
                    )
                  ],
                ),
              ),

          ),
          Consumer<Cart>(
              builder: (_, deliveryPro, child) => Card(
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Delivery Options',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      InkWell(
                    onTap: () {
                    // deliveryPro.standardDelivery(this.widget.amount);
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:15.0),
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.circle, color: kBrandColor),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: deliveryPro.getStandardDelivery
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
                       Container(
                         width: 300,
                         child: ListTile(
                           title: Row(
                             children: [
                               Text('N500 ', style: TextStyle(fontWeight: FontWeight.bold),),
                               Text('Standard Delivery'),
                             ],
                           ),
                           subtitle: Text('30 Minutes Maximum Delivery Time'),
                         ),
                       )
                      ],
                    ),
                  ),
                  line(context),
                   InkWell(
                    onTap: () async{
                      // print('this is address ${deliveryPro.getExpressPickUpAddress}');
                   deliveryPro.pickUpSale();
                   await  showModalBottomSheet(
                    context: context,
                          shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
                    builder: (ctx) {
                      return BottomSheetModel();
                    });
                    // if(res == deliveryPro.getExpressPickUpAddress){
                    //   print('this is from main Check out ${deliveryPro.getExpressPickUpAddress}');
                    // }
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:15.0),
                          // decoration: BoxDecoration(
                          //     shape: BoxShape.circle, color: kBrandColor),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: deliveryPro.getPickUpSale
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
                       Container(
                         width: 300,
                         child: ListTile(
                           title:   Text('Pick Up from Order Sales Partner'),
                           subtitle: Text('Choose the closest Location to You for Pickup'),
                         ),
                       )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  deliveryPro.getPickUpSale == false ? SizedBox() : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pick Up Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                            SizedBox(height: 5.0,),
                            deliveryPro.getExpressPickUpAddress == null ? Text('Sailas Charles'): Text(deliveryPro.getExpressPickUpAddress.toString()),
                          ],
                        ),

                         Container(
                           margin: EdgeInsets.only(left:30.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Contacts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                              Container(
                                width: 180,
                                margin: EdgeInsets.only(bottom: 10.0, top: 5.0),
                                child: Text('28 Peace Str. Ikeja, Lagos, Nigeria.')),
                              Text('2348164293279'),
                            ],
                        ),
                         ),
                      ],
                    ),
                  )
                    ],
                  ),
                ),
              )),
              Consumer<Cart>(
              builder: (_, ordermethod, child) =>  Card(
                child: 
                ordermethod.getcardNumber == null && ordermethod.getcardName == null && ordermethod.getcardCVV == null && ordermethod.getcardExpiredate == null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(left:10.0),
                        child: Text('Payment',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),
                    ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutAddCardScreen()));
                    },
                    child: Row(
                      children: [
                    Container(
                            margin: EdgeInsets.all(15.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                border: Border.all(color: kBrandColor, width: 2)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 3, bottom: 3),
                                child: Text(
                                  'Add Credit Card',
                                  style: TextStyle(color: kBrandColor),
                                )))
                      ],
                    ),
                  )]): Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(left:30.0),
                            child: Text('Payment',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),
                        ),
                        InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutAddCardScreen()));
                    },
                    child: Row(
                      children: [
                    Container(
                            margin: EdgeInsets.all(15.0),
                            padding: EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                color: Colors.green.withOpacity(.1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                border: Border.all(color: kBrandColor, width: 2)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0, top: 3, bottom: 3),
                                child: Text(
                                  'Change Credit Card',
                                  style: TextStyle(color: kBrandColor),
                                )))
                      ],
                    ),
                  ),
                      ],
                    ),                  
                  
           ListTile(
                        title: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 8.0, bottom: 3.0, top: 8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Card Number',
                                    style: TextStyle(
                                        color: kBrandColor, fontSize: 15.0),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    ordermethod.getcardNumber,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ])),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 8.0,
                                bottom: 15.0,
                                top: 20.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Name on Card',
                                    style: TextStyle(
                                        color: kBrandColor, fontSize: 15.0),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    ordermethod.getcardName,
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ])),
                      ),
                      ordermethod.getcardNumber == null && ordermethod.getcardName == null && ordermethod.getcardCVV == null && ordermethod.getcardExpiredate == null ? SizedBox() :ListTile(
                        title: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 8.0, bottom: 3.0, top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Expiry Date',
                                        style: TextStyle(
                                            color: kBrandColor, fontSize: 15.0),
                                      ),
                                      SizedBox(height: 3.0),
                                      Text(
                                        ordermethod.getcardExpiredate,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ]),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'CVV',
                                          style: TextStyle(
                                              color: kBrandColor,
                                              fontSize: 15.0),
                                        ),
                                        SizedBox(height: 3.0),
                                        Text(
                                          ordermethod.getcardCVV,
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                      ]),
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height:20.0),
                  Center(child: Image.asset('asset/card.png'))
                  ],
                ),
              )),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, left:30.0, bottom: 8.0),
                      child: Text('Sub-total', style: TextStyle(fontSize: 18.0)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right:30.0, bottom: 8.0),
                      // child: Text('${this.widget.amount}'),
                    ),
                  ],
                ),
              ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left:30.0, bottom: 8.0),
                      child: Text('Total to Pay', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right:30.0, bottom: 8.0),
                      // child: Text(Provider.of<Cart>(context, listen: false).getStandardDelivery == false ?'${this.widget.amount}':'${this.widget.amount + 500}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),

              Consumer<Cart>(
              builder: (_, submitOrder, child) =>  Container(
                    height: 70.0,
                     margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: submitOrder.getAddress == null && 
                          submitOrder.getcardNumber == null && 
                          submitOrder.getcardName == null && 
                          submitOrder.getcardCVV == null && 
                          submitOrder.getcardExpiredate == null &&
                           submitOrder.getPickUpSale == false &&
                           submitOrder.getStandardDelivery == false ? kPrimaryColor.withOpacity(.6) : kPrimaryColor,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: FlatButton(
                        onPressed:() async{
                          print(submitOrder.getStandardDelivery);
                          if(submitOrder.getAddress == null && 
                          submitOrder.getcardNumber == null && 
                          submitOrder.getcardName == null && 
                          submitOrder.getcardCVV == null && 
                          submitOrder.getcardExpiredate == null
                           ){
                            print('Complete your info');
                          }else if( submitOrder.getPickUpSale == false &&
                           submitOrder.getStandardDelivery == false){

                               print('Complete Pickup info');
              
                          }else{
                            if (!await context
                              .read<Cart>()
                              .orders(
                              Provider.of<Authentication>(context, listen: false).getAddressBook.id.toString(),
                              'online', 
                              Provider.of<Authentication>(context, listen: false).getAddressBook.deliveryInstructions.toString(),
                               Provider.of<Authentication>(context, listen: false).getAddressBook.deliveryInstructions.toString()))
                             {
                            switch (context.read<Cart>().orderState) {
                              case OrderState.error:
                                return _scaffoldKey.currentState.showSnackBar(SnackBar(
                                    content: Text('Error Processsing Your Order')));
                            }
                          } else {
                              //  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              //  SuccessfulCheckOutPage(amount: double.parse("${Provider.of<Cart>(context, listen: false).getStandardDelivery == false ? this.widget.amount:this.widget.amount + 500}"), products: this.widget.products,)), (Route<dynamic> route) => false);
                          }        
                          
                                            // print('Order Submited');
                                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> SuccessfulCheckOutPage()));
                          }
                        },
                        child: Text('Place Order', style: TextStyle(color: Colors.white),)),
                      )),
        ]))));
  }
}
