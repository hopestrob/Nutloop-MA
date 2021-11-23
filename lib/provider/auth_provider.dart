import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nuthoop/boarding/Welcome/welcome_screen.dart';
import 'package:nuthoop/helper/api.dart';
import 'package:nuthoop/model/addressBook.dart';
import 'package:nuthoop/model/subject.dart';
import 'package:nuthoop/model/transactionModel.dart';
import 'package:nuthoop/model/user.dart';
import 'package:nuthoop/model/userLoginModel.dart';
import 'package:nuthoop/model/userRegMode.dart';
import 'package:nuthoop/screens/Home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import '../model/Wallet_model.dart';

enum RegisterState { initial, error, loading, complete }
enum RegisterError { emailTaken, invalidPassword, otherErrors }

enum FacebookState { initial, error, loading, complete }
enum FacebookError { emailTaken, otherErrors }

enum LoginState { initial, error, loading, complete }
enum LoginError { invalidEmail, invalidPassword, otherErrors }

enum PassWordError { invalidPassword, otherErrors }

enum PassWordResetError { invalidEmail, emailNotfound, otherErrors }
enum PassWordResetState { initial, error, loading, complete }

enum ProfileUpdateError { otherErrors }
enum ProfileUpdateState { initial, error, loading, complete }

enum RedirectState { noToken, tokenExpire }

enum AddtocartState { initial, error, loading, complete }
enum AddtocartError { emailTaken, otherErrors }

enum SendContactState { initial, error, loading, complete }

class Authentication with ChangeNotifier {
  Authentication(context) {
    getProfileDetail(context);
    getAddressBookList(context);
    getWallet(context);
    getWalletTransaction();
    getAddressInOrderDetail(context);
    getsubject();
  }

  Api api = new Api();
  List<TransactionModel> _getWalletData = <TransactionModel>[];

  List<TransactionModel> get getWalletData {
    return [...?_getWalletData];
  }

  AddressBook _getAddressBookDetail = AddressBook();
  AddressBook get getAddressBookDetail => _getAddressBookDetail;

  List<AddressBook> _getAddressBook = <AddressBook>[];
  List<AddressBook> get getAddressBook {
    return [...?_getAddressBook];
  }

  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final fbLogin = FacebookLogin();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  RedirectState _redirectState;
  RedirectState get redirectState => _redirectState;

  RegisterState _registerstate =
      RegisterState.initial; // Initial State of the form
  RegisterState get registerState => _registerstate;

  RegisterError _registerError;
  RegisterError get registerError => _registerError;

  FacebookState _facebookstate =
      FacebookState.initial; // Initial State of the form
  FacebookState get facebookState => _facebookstate;

  FacebookError _facebookError;
  FacebookError get facebookError => _facebookError;

  LoginState _loginstate = LoginState.initial;
  LoginState get loginState => _loginstate;

  LoginError _loginError;
  LoginError get loginError => _loginError;

  PassWordError _passWordError;
  PassWordError get getPassWordError => _passWordError;

  PassWordResetError _passWordResetError;
  PassWordResetError get getPassWordResetError => _passWordResetError;

  PassWordResetState _passWordResetState = PassWordResetState.initial;
  PassWordResetState get passWordResetState => _passWordResetState;

  ProfileUpdateError _profileUpdateError;
  ProfileUpdateError get getprofileUpdateError => _profileUpdateError;

  ProfileUpdateState _profileUpdateState = ProfileUpdateState.initial;
  ProfileUpdateState get profileUpdateState => _profileUpdateState;

  bool passwordVisible = true;
  bool get getPasswordVisible => true;

  String _getAuthUser;
  String get getAuthUser => _getAuthUser;

  void setAuthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _getAuthUser = prefs.getString('authName');
    notifyListeners();
  }

  String _getAuthRefer;
  String get getAuthRefer => _getAuthRefer;

  void setAuthRefer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _getAuthUser = prefs.getString('refer_code');
    notifyListeners();
  }

  UserModel _sinleUser = UserModel();
  UserModel get getSingleUserDetail => _sinleUser;

  WalletModel _sinleUserWallet = WalletModel();
  WalletModel get getSingleUserWallet => _sinleUserWallet;

  void toggle() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

// Register with EMail Password and phone
  Future<bool> registerUser(
      String name, email, password, passwordConfirmation, phoneNumber) async {
    try {
      _registerstate = RegisterState
          .loading; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      //Pass user info to Api
      var responseJson = await api.registerData(
          name, email, password, passwordConfirmation, phoneNumber);
      //Check for Errors Using Status Code 400
      if (responseJson.statusCode == 400) {
        var encodeFirst = json.encode(responseJson.body);
        var data = jsonDecode(jsonDecode(encodeFirst));
        if (data["message"] == "The password must be at least 6 characters.") {
          _registerError = RegisterError.invalidPassword;
          _registerstate = RegisterState.error;
          notifyListeners();
          return false;
        } else if (data["message"] == "The email has already been taken.") {
          _registerError = RegisterError.emailTaken;
          _registerstate = RegisterState.error;
          notifyListeners();
          return false;
        }
      }
      var data = json.decode(responseJson.body);

      var usersReg = UserRegModel.fromJson(data);
      var authName = usersReg.data.user.name;
      var authtoken = usersReg.data.token;

      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, authName);
      prefs.setString(key, authtoken);
      _registerstate = RegisterState.complete;
      notifyListeners();
      print(prefs.getString('authName'));
      return true;
    } catch (exception) {
      _registerstate = RegisterState.error;
      _registerError = RegisterError.otherErrors;
      print(exception);
      return false;
    }
  }

// Login with EMail and PAssword
  Future<bool> loginUser(String email, String password) async {
    print('srated');
    try {
      _loginstate = LoginState.loading;
      notifyListeners();
      var responseJson = await api.loginData(email, password);
      var data = json.decode(responseJson.body);
      print(responseJson.statusCode);
      print(data);
      if (responseJson.statusCode == 200) {
        // if(responseJson.statusCode == 200 && data["message"] == "Login successfully"){
        var result = json.decode(responseJson.body);
        var users = UserLoginModel.fromJson(result);
        print("Users are result $result");
        var authtoken = users.data.accessToken;
        var authName = users.data.user.name;
        var referCode = users.data.user.referCode;
        final prefs = await SharedPreferences.getInstance();
        final key = 'token';
        final keys = 'authName';
        final keyes = 'refer_code';
        prefs.setString(key, authtoken);
        prefs.setString(keys, authName);
        prefs.setString(keyes, referCode);
        _loginstate = LoginState.complete;
        notifyListeners();
        return true;
      }

      if (responseJson.statusCode == 401) {
        if (data["message"] == "Invalid credentials") {
          _loginstate = LoginState.error;
          _loginError = LoginError.invalidEmail;
          notifyListeners();
          return false;
        }
        _loginstate = LoginState.error;
        _loginError = LoginError.invalidPassword;
        notifyListeners();
        return false;
      }
      if (responseJson.statusCode != 200) {
        _loginstate = LoginState.error;
        _loginError = LoginError.otherErrors;
        notifyListeners();
        return false;
      }
      return false;
    } catch (exception) {
      print('this is login exception $exception');
      _loginstate = LoginState.error;
      _loginError = LoginError.otherErrors;
      notifyListeners();
      return false;
    }
  }

// reset Password
  Future<bool> resetPassword(String email) async {
    _passWordResetState = PassWordResetState.loading;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    var responseJson = await api.resetPassword(authToken, email);
    var data = json.decode(responseJson.body);
    print(data);
    if (responseJson.statusCode == 401) {
      if (authToken != null) {
        prefs.remove('token');
        notifyListeners();
      }
      _passWordResetError = PassWordResetError.invalidEmail;
      _passWordResetState = PassWordResetState.error;
      notifyListeners();
      return false;
    }
    if (responseJson.statusCode == 404) {
      _passWordResetError = PassWordResetError.emailNotfound;
      _passWordResetState = PassWordResetState.error;
      notifyListeners();
      return false;
    }
    if (responseJson.statusCode != 200) {
      _passWordResetError = PassWordResetError.otherErrors;
      _passWordResetState = PassWordResetState.error;
      notifyListeners();
      return false;
    }
    if (responseJson.statusCode == 200)
      _passWordResetState = PassWordResetState.complete;
    print(responseJson.statusCode);
    return true;
  }

// Social Media SignUp

//Google SignUp
  // ignore: deprecated_member_use
  Future<auth.User> signUpWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
        accessToken: gSA.accessToken,
        idToken: gSA.idToken,
      );

      auth.UserCredential authResult =
          await _auth.signInWithCredential(credential);
      var _user = authResult.user;

      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);

      // ignore: deprecated_member_use
      auth.User currentUser = _auth.currentUser;

      assert(_user.uid == currentUser.uid);
      var responseJson = await api.socialSignUp(
          _user.displayName, _user.email, _user.uid, 'Google');
      var data = json.decode(responseJson.body);
      print(data);
      if (responseJson.statusCode == 200 && data['status_code'] == 200) {
        var authtoken = data['data']['access_token'];
        print('this is access token $data');
        final prefs = await SharedPreferences.getInstance();
        final key = 'token';
        final keys = 'authName';
        prefs.setString(keys, _user.displayName);
        prefs.setString(key, authtoken);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => Homepage(authName: _user.displayName)),
            (Route<dynamic> route) => false);
      }

      return _user;
    } catch (exception) {
      print('this is exception from api google ${exception.message}');
      notifyListeners();
      // An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
      return null;
    }
  }

  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  // Future<Null> signUpWithFB(BuildContext context) async {
  //   final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final FacebookAccessToken accessToken = result.accessToken;
  //       print('''
  //        Logged in!

  //        Token: ${accessToken.token}
  //        User id: ${accessToken.userId}
  //        Expires: ${accessToken.expires}
  //        Permissions: ${accessToken.permissions}
  //        Declined permissions: ${accessToken.declinedPermissions}
  //        ''');
  //       break;
  //     case FacebookLoginStatus.cancelledByUser:
  //       print('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${result.errorMessage}');
  //       break;
  //   }
  // }

//SignUp with Facebook
  Future signUpWithFB(BuildContext context) async {
    try {
      _facebookstate = FacebookState.loading;
      notifyListeners();
      final FacebookLoginResult result = await fbLogin.logIn(["email"]);
      print(result.status);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
          final profile = json.decode(graphResponse.body);

          auth.AuthCredential credential =
              auth.FacebookAuthProvider.credential(token);
          auth.UserCredential authResult =
              await _auth.signInWithCredential(credential);
          var _user = authResult.user;

          assert(!_user.isAnonymous);
          assert(await _user.getIdToken() != null);

          auth.User currentUser = _auth.currentUser;

          assert(_user.uid == currentUser.uid);
          var responseJson = await api.socialSignUp(
              profile['name'], profile['email'], profile['id'], 'Facebook');
          var data = json.decode(responseJson.body);
          if (responseJson.statusCode == 200 &&
              data['message'] == "Login successfully") {
            var authtoken = data['data']['access_token'];
            final prefs = await SharedPreferences.getInstance();
            final key = 'token';
            final keys = 'authName';

            prefs.setString(keys, profile['name']);
            prefs.setString(key, authtoken);
            _facebookstate = FacebookState.complete;
            notifyListeners();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Homepage(authName: profile['name'])),
                (Route<dynamic> route) => false);
          }
          if (responseJson.statusCode == 400 && data['data'] == false) {
            print('Name is required');
            _facebookstate = FacebookState.error;
            _facebookError = FacebookError.otherErrors;
            notifyListeners();
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          _isLoggedIn = false;
          _facebookstate = FacebookState.error;
          _facebookError = FacebookError.otherErrors;
          notifyListeners();
          break;
        case FacebookLoginStatus.error:
          _facebookstate = FacebookState.error;
          _facebookError = FacebookError.otherErrors;
          notifyListeners();
          _isLoggedIn = false;
          break;
      }
    } catch (exception) {
      print('this is exception from api facebook ${exception.message}');
      _facebookError = FacebookError.emailTaken;
      _facebookstate = FacebookState.error;
      notifyListeners();
      // An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
      return false;
    }
  }

// Sign In With Social Media
  Future<auth.User> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    auth.UserCredential authResult =
        await _auth.signInWithCredential(credential);
    var _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    auth.User currentUser = _auth.currentUser;

    assert(_user.uid == currentUser.uid);
    var responseJson = await api.socialSignIn(_user.uid, 'Google');
    print(responseJson.statusCode);

    print(_user.uid);
    var data = json.decode(responseJson.body);
    if (responseJson.statusCode == 200 &&
        data['message'] == "Login successfully") {
      var authtoken = data['data']['access_token'];
      print('this is access token $authtoken');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, _user.displayName);
      prefs.setString(key, authtoken);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => Homepage(authName: _user.displayName)),
          (Route<dynamic> route) => false);
    }

    return _user;
  }

// Sign In with facebook
  Future signInFB(BuildContext context) async {
    try {
      _facebookstate = FacebookState.loading;
      notifyListeners();
      final FacebookLoginResult result = await fbLogin.logIn(["email"]);
      print(result.status);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final token = result.accessToken.token;
          final graphResponse = await http.get(
              'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
          final profile = json.decode(graphResponse.body);

          auth.AuthCredential credential =
              auth.FacebookAuthProvider.credential(token);
          auth.UserCredential authResult =
              await _auth.signInWithCredential(credential);
          var _user = authResult.user;

          assert(!_user.isAnonymous);
          assert(await _user.getIdToken() != null);

          auth.User currentUser = _auth.currentUser;

          assert(_user.uid == currentUser.uid);

          var responseJson = await api.socialSignIn(profile['id'], 'Facebook');
          print(responseJson.statusCode);
          print(profile['id']);
          var data = json.decode(responseJson.body);
          print(data);
          if (responseJson.statusCode == 200 &&
              data['message'] == "Login successfully") {
            var authtoken = data['data']['access_token'];
            print('this is access token $authtoken');
            final prefs = await SharedPreferences.getInstance();
            final key = 'token';
            final keys = 'authName';
            prefs.setString(keys, profile['name']);
            prefs.setString(key, authtoken);
            _facebookstate = FacebookState.complete;
            notifyListeners();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Homepage(authName: profile['name'])),
                (Route<dynamic> route) => false);
          }
          if (responseJson.statusCode == 400 && data['data'] == false) {
            _facebookstate = FacebookState.error;
            _facebookError = FacebookError.otherErrors;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Kindly Register to Login')));
          }
          break;
        case FacebookLoginStatus.cancelledByUser:
          _facebookstate = FacebookState.error;
          _facebookError = FacebookError.otherErrors;
          notifyListeners();
          _isLoggedIn = false;
          break;
        case FacebookLoginStatus.error:
          _facebookstate = FacebookState.error;
          _facebookError = FacebookError.otherErrors;
          notifyListeners();
          _isLoggedIn = false;
          break;
      }
    } catch (exception) {
      print('this is exception from api facebook ${exception.message}');
      _facebookError = FacebookError.emailTaken;
      _facebookstate = FacebookState.error;
      notifyListeners();
      // An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.
      return false;
    }
  }

// Change Login User Password
  Future<bool> changePassword(
      String oldPassword, newPassword, conNewPassword) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.changePassword(
          authToken, oldPassword, newPassword, conNewPassword);
      var data = json.decode(responseJson.body);
      print(responseJson.statusCode);
      if (responseJson.statusCode == 401) {
        if (data["message"] == " Invalid credentials") {
          _passWordError = PassWordError.invalidPassword;
          notifyListeners();
          return false;
        }
        _passWordError = PassWordError.invalidPassword;
        notifyListeners();
        return false;
      }
      if (responseJson.statusCode != 200) {
        _passWordError = PassWordError.invalidPassword;
        notifyListeners();
        return false;
      }
      if (responseJson.statusCode == 200) notifyListeners();
      return true;
    } catch (exception) {
      // print(exception);
      _loginstate = LoginState.error;
      _loginError = LoginError.otherErrors;
      notifyListeners();
      return false;
    }
  }

  // ignore: missing_return
  addAddressBook(String firstName, lastName, phoneNumber, mobileNumber, houseNo,
      street, city, area, deliveryNote) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.addAddress(authToken, firstName, lastName,
          phoneNumber, mobileNumber, houseNo, street, area, city, deliveryNote);
      // if Status code is not 400 and its 200 then User has been register and save token to shared Pref
      print(responseJson.statusCode);
      print(responseJson);
      if (responseJson.statusCode == 200) {
        var data = json.decode(responseJson.body);
        print(data);
      }
      // return _getAddressBook;

    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  // ignore: missing_return
  void updateAddressBook(int userId, String firstName, lastName, phoneNumber,
      mobileNumber, houseNo, street, city, area, deliveryNote) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.updateAddress(
          userId,
          authToken,
          firstName,
          lastName,
          phoneNumber,
          mobileNumber,
          houseNo,
          street,
          area,
          city,
          deliveryNote);
      print(json.decode(responseJson.body));
      if (responseJson.statusCode == 200) {
        var data = json.decode(responseJson.body);

        // ignore: unused_local_variable
        var list = data['data'] as List;
        // notifyListeners();
      }
      // return _getAddressBook;

    } catch (exception) {
      // print(exception);
      return null;
    }
  }

  Future<bool> deleteAddressBook(int userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.deleteDatas(
          authToken, 'user/addresses-book/delete', userId);
      print(responseJson.statusCode);
      print(json.decode(responseJson.body));
      return true;
    } catch (exception) {
      print("deleteAddressBook $exception");
      return false;
    }
  }

  // Future<AddressBook>
  Future<List<AddressBook>> getAddressBookList(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson =
          await api.getData(authToken, "/user/addresses-book/list");
      print('this is user address status code ${responseJson.statusCode}');
      if (responseJson.statusCode == 200) {
        var data = json.decode(responseJson.body);
        var result = data['data'] as List;
        _getAddressBook = result.map((e) => AddressBook.fromJson(e)).toList();
        notifyListeners();
      }
      if (responseJson.statusCode != 200) {
        return null;
      }
      // refresh token
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401 ||
            responseState.statusCode == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }

        return null;
      }

      return _getAddressBook;
    } catch (exception) {
      print("getAddressBookList $exception");
      _loginstate = LoginState.error;
      _loginError = LoginError.otherErrors;
      notifyListeners();
      return null;
    }
  }

  Future<List<AddressBook>> getAddressInOrderDetail(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson =
          await api.getData(authToken, "/user/addresses-book/list");
      print(authToken);
      if (responseJson.statusCode != 200) {
        return null;
      }
      if (responseJson.statusCode == 401) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (Route<dynamic> route) => false);
      }
      if (responseJson.statusCode == 200) {
        var data = json.decode(responseJson.body);
        var result = data['data'] as List;
        print('this is Addressbook Orders details $data');
        _getAddressBook = result.map((e) => AddressBook.fromJson(e)).toList();
        notifyListeners();
      }
      return _getAddressBook;
    } catch (exception) {
      print("getAddressBookList $exception");
      return null;
    }
  }

  // Future<AddressBook>
  Future<AddressBook> getAddressBookDetails(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson =
          await api.getData(authToken, "/user/addresses-book/details/$id");
      var data = json.decode(responseJson.body);
      if (responseJson.statusCode != 200) {
        return null;
      }

      if (responseJson.statusCode == 200) {
        _getAddressBookDetail = AddressBook.fromJson(data['data']);
        notifyListeners();
        // _getAddressBookDetail =
        //     data.map((job) => new AddressBook.fromJson(job)).toList();
      }
      return _getAddressBookDetail;
    } catch (exception) {
      print('this is exception from single address page $exception');
      return null;
    }
  }

  // get Profile Details of logged in User
  Future<UserModel> getProfileDetail(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.getProfile(authToken, "/user/auth/me");
      var data = json.decode(responseJson.body);

      if (responseJson.statusCode == 200) {
        _sinleUser = UserModel.fromJson(data);
        notifyListeners();
      }
      // refresh token
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401 ||
            responseState.statusCode == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }

        return null;
      }

      return _sinleUser;
    } catch (exception) {
      if (exception is SocketException) {
        //treat SocketException
        print("Socket exception: Profile ${exception.toString()}");
        _loginstate = LoginState.error;
        _loginError = LoginError.otherErrors;
        notifyListeners();
      } else if (exception is TimeoutException) {
        //treat TimeoutException
        print("Timeout exception: profile ${exception.toString()}");
        _loginstate = LoginState.error;
        _loginError = LoginError.otherErrors;
        notifyListeners();
      } else
        print("Unhandled exception: profli ${exception.toString()}");
      _loginstate = LoginState.error;
      _loginError = LoginError.otherErrors;
      notifyListeners();
      return null;
    }
  }

  //Update Profile
  Future<bool> updateProfile(context, String name, email, phone) async {
    try {
      _profileUpdateState = ProfileUpdateState.loading;
      notifyListeners();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.updateProfile(authToken, name, email, phone);
      var data = json.decode(responseJson.body);
      print('this is error $data');
      // refresh token
      if (responseJson.statusCode == 401 || responseJson.statusCode == 404) {
        _profileUpdateError = ProfileUpdateError.otherErrors;
        _profileUpdateState = ProfileUpdateState.error;
        notifyListeners();
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return false;
        }
        if (res['status_code'] == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return false;
        }

        return false;
      }

      if (responseJson.statusCode != 200) {
        _profileUpdateError = ProfileUpdateError.otherErrors;
        _profileUpdateState = ProfileUpdateState.error;
        notifyListeners();
        return false;
      }
      if (responseJson.statusCode == 200)
        _profileUpdateState = ProfileUpdateState.complete;
      notifyListeners();
      return true;
    } catch (exception) {
      print("updateProfile $exception");
      return null;
    }
  }

  // Get Wallet
  Future<WalletModel> getWallet(context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var responseJson = await api.getData(authToken, "/user/my-wallet");
      if (responseJson.statusCode == 200) {
        var data = json.decode(responseJson.body);
        print('this is wallet data $data');
        _sinleUserWallet = WalletModel.fromJson(data);
        notifyListeners();
      }
      if (responseJson.statusCode != 200) {
        return null;
      }
      // refresh token
      if (responseJson.statusCode == 401) {
        var responseState = await api.refreshToken(authToken);
        var res = json.decode(responseState.body);

        if (responseState.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          var authtoken = res['data']['access_token'];
          final key = 'token';
          prefs.setString(key, authtoken);
        }
        if (responseState.statusCode == 401 ||
            responseState.statusCode == 500) {
          var authToken = prefs.getString('token');
          if (authToken != null) {
            prefs.remove('token');
            notifyListeners();
          }
          if (authToken == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false);
          }
          return null;
        }

        return null;
      }

      return _sinleUserWallet;
    } catch (exception) {
      print("getWallet $exception");
      return null;
    }
  }

  bool _walletLoaded = false;
  bool get walletLoaded => _walletLoaded;
  // Get Wallet
  // ignore: missing_return
  Future<List<TransactionModel>> getWalletTransaction() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _walletLoaded = false;
        notifyListeners();
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var authToken = prefs.getString('token');
      var response = await api.getData(authToken, "/user/wallet-transactions");
      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200 && result['status_code'] == 200) {
        var list = result['data'] as List;
        _getWalletData = list.map((e) => TransactionModel.fromJson(e)).toList();
        _walletLoaded = true;
        notifyListeners();
      }
      // print('this is wallet transaction ${_getWalletData.length}');
      return _getWalletData;
    } catch (exception) {
      print('getWalletTransaction $exception');
      return null;
    }
  }

  List<SubjectModel> _subjectContact = <SubjectModel>[];
  List<SubjectModel> get getsubjectContact => _subjectContact;
  bool _readyState = false;
  bool get getReadyState => _readyState;
  // ignore: missing_return
  Future<List<SubjectModel>> getsubject() async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _readyState = false;
        notifyListeners();
      });
      var response = await api.getProduct("/public/contact-us-subjects");

      var result = json.decode(response.body);
      if (response.statusCode != 200) {
        return null;
      }
      if (response.statusCode == 200) {
        var list = result['data'] as List;
        print('this is subject result $list');
        _subjectContact = list.map((e) => SubjectModel.fromJson(e)).toList();
        _readyState = true;
        notifyListeners();
        return _subjectContact;
      }
    } catch (exception) {
      if (exception is SocketException) {
        //treat SocketException
        print("Socket exception: getsubject ${exception.toString()}");
      } else if (exception is TimeoutException) {
        //treat TimeoutException
        print("Timeout exception: getsubject ${exception.toString()}");
      } else
        print("Unhandled exception: getsubjec ${exception.toString()}");
      return null;
    }
  }

  SendContactState _sendContactState;
  SendContactState get sendContactState => _sendContactState;
  String _contactError;
  String get contactError => _contactError;

  Future<bool> sendContactMessage(
      String name, email, phoneNumber, message, subjectid) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token').toString();
      _sendContactState = SendContactState.loading;
      notifyListeners();
      var response = await api.sendContact(
          token, name, email, phoneNumber, message, subjectid);
      final responseJson = json.decode(response.body);
      print('this is Contact  add $responseJson');
      if (response.statusCode == 200) {
        _sendContactState = SendContactState
            .complete; // When User Touches the Sign Up Button, it will Load
        notifyListeners();
        return true;
      }
      print('this is error message ${responseJson['message']}');
      _contactError = responseJson['message'];
      _sendContactState = SendContactState.error;
      notifyListeners();
      return false;
    } catch (exception) {
      print('this is contact $exception');
      _sendContactState = SendContactState
          .error; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      return false;
      // return null;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    if (authToken != null) {
      prefs.remove('token');
      _getAddressBookDetail = AddressBook();
      _getAddressBook = <AddressBook>[];
      _isLoggedIn = false;
      _registerstate = RegisterState.initial;
      _facebookstate = FacebookState.initial;
      _loginstate = LoginState.initial;
      _passWordResetState = PassWordResetState.initial;
      _profileUpdateState = ProfileUpdateState.initial;
      passwordVisible = false;
      _sinleUser = UserModel();
      _sinleUserWallet = WalletModel();
      _readyState = false;
      notifyListeners();
    }
  }

  // Logout User
  logout3(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authToken = prefs.getString('token');
    if (authToken != null) {
      prefs.remove('token');
      notifyListeners();
    }
    if (authToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (Route<dynamic> route) => false);
    }
    // prefs.remove('token');
  }
}

// Exception has occurred.
// PlatformException (PlatformException(firebase_auth, com.google.firebase.auth.FirebaseAuthUserCollisionException: An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address., {code: account-exists-with-different-credential, additionalData: {authCredential: {providerId: facebook.com, signInMethod: facebook.com, token: 262114996}, email: mine4christ@gmail.com}, message: An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.}, null))
// if (response.statusCode == 401) {
//         var responseState = await api.refreshToken(authToken);
//         var res = json.decode(responseState.body);
//         print(res);
//         print(res['status_code']);

//         if (responseState.statusCode == 200) {
//           print('this is status code from refresh ${responseState.statusCode}');
//           final prefs = await SharedPreferences.getInstance();
//           var authtoken = res['data']['access_token'];
//           final key = 'token';
//           prefs.setString(key, authtoken);
//         }
//         if (responseState.statusCode == 401) {
//           var authToken = prefs.getString('token');
//           if (authToken != null) {
//             prefs.remove('token');
//             notifyListeners();
//           }
//           if (authToken == null) {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => WelcomeScreen()),
//                 (Route<dynamic> route) => false);
//           }
//           return null;
//         }
//         if (res['status_code'] == 500) {
//           var authToken = prefs.getString('token');
//           if (authToken != null) {
//             prefs.remove('token');
//             notifyListeners();
//           }
//           if (authToken == null) {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (context) => WelcomeScreen()),
//                 (Route<dynamic> route) => false);
//           }
//           return null;
//         }
//         // print(authToken);
//         // SharedPreferences prefs = await SharedPreferences.getInstance();
//         // var authToken = prefs.getString('token');
//         // if (authToken != null) {
//         //   prefs.remove('token');
//         //   notifyListeners();
//         // }
//         // if (authToken == null) {
//         //   Navigator.of(context).pushAndRemoveUntil(
//         //       MaterialPageRoute(builder: (context) => WelcomeScreen()),
//         //       (Route<dynamic> route) => false);
//         // }
//         // return null;
//       }
