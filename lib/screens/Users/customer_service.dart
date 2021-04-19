import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/widget/chatDetailPage.dart';
import 'package:nutloop_ecommerce/widget/chatpage.dart';

class CustomerService extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ChatDetailPage(),
      ),

    );
  }
}