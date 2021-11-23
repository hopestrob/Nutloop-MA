import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

Widget noInternet(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [noIntImage(), noIntText(context)]),
    ),
  );
}

noIntImage() {
  return SvgPicture.asset(
    'asset/images/no_internet.svg',
    fit: BoxFit.contain,
  );
}

noIntText(BuildContext context) {
  return Container(
      child: Text('NO_INTERNET', style: TextStyle(color: Colors.black)));
}

noIntDec(BuildContext context) {
  return Container(
      padding: EdgeInsetsDirectional.only(top: 30.0, start: 30.0, end: 30.0),
      child: Text('NO_INTERNET_DISC', style: TextStyle(color: Colors.black)));
}

// class AppBtn extends StatelessWidget {
//   final String title;
//   final AnimationController btnCntrl;
//   final Animation btnAnim;
//   final VoidCallback onBtnSelected;

//   const AppBtn(
//       {Key key, this.title, this.btnCntrl, this.btnAnim, this.onBtnSelected})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new AnimatedBuilder(
//       builder: _buildBtnAnimation,
//       animation: btnCntrl,
//     );
//   }
// }
