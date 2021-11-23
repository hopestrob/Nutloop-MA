import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';

SnackBar displayMessage(String msg) {
  return new SnackBar(
    backgroundColor: kBrandColor,
    content: Text(msg),
    duration: Duration(seconds: 5),
  );
}
