import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'subpage1.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CupertinoButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (context) => SubPage()));
            },
            child: Center(
              child: Text('hello from Page 2'),
            )),
      ),
    );
  }
}
