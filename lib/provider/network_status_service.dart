// import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkStatusService with ChangeNotifier {
  bool _isNetworkAvailables = false;
  bool get isNetworkAvailables => _isNetworkAvailables;

  isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      _isNetworkAvailables = true;
      notifyListeners();
      // return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _isNetworkAvailables = true;
      notifyListeners();
      // return true;
    }
    _isNetworkAvailables = false;
    notifyListeners();
    // return false;
  }
}
