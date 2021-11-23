import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FilterProducts with ChangeNotifier {

  bool _fiveRating = false;
  bool _fourRating = false;
  bool _threeRating = false;
  bool _twoRating = false;
  bool _oneRating = false;
  bool _noRating = false;
  bool get getFiveRating => _fiveRating;
  bool get getFourRating => _fourRating;
  bool get getThreeRating => _threeRating;
  bool get getTwoRating => _twoRating;
  bool get getOneRating => _oneRating;
  bool get getNoRating => _noRating;

   String fiveRatVal, fourRatVal, threeRatVal, twoRatVal, oneRatVal, noRatVal;
  String get getfiveRatVal => fiveRatVal;
  String get getfourRatVal => fourRatVal;
  String get getthreeRatVal => threeRatVal;
  String get gettwoRatVal => twoRatVal;
  String get getoneRatVal => oneRatVal;
  String get getnoRatVal => noRatVal;

  void setFiveRating(String fiveRatValue){
    _fiveRating = !_fiveRating;
    fiveRatVal = fiveRatValue;
    notifyListeners();
  }
  void setFourRating(String fourRatValue){
    _fourRating = !_fourRating;
    fourRatVal = fourRatValue;
    notifyListeners();
  }
   void setThreeRating(String threeRatValue){
    _threeRating = !_threeRating;
    threeRatVal = threeRatValue;
    notifyListeners();
  }
  void setTwoRating(String twoRatValue){
    _twoRating = !_twoRating;
    twoRatVal = twoRatValue;
    notifyListeners();
  }

    void setOneRating(String oneRatValue){
    _oneRating = !_oneRating;
    oneRatVal = oneRatValue;
    notifyListeners();
  }

    void setNoRating(String noRatValue){
    _noRating = !_noRating;
    noRatVal = noRatValue;
    notifyListeners();
  }
}