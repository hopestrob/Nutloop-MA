import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nutloop_ecommerce/helper/api.dart';
import 'package:nutloop_ecommerce/model/addressBook.dart';
import 'package:nutloop_ecommerce/model/user.dart';
import 'package:nutloop_ecommerce/model/userRegMode.dart';
import 'package:nutloop_ecommerce/screens/Home/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;




enum RegisterState {initial, error, loading, complete }
enum RegisterError {emailTaken, invalidPassword, otherErrors}


enum LoginState {initial, error, loading, complete }
enum LoginError {invalidEmail, invalidPassword, otherErrors}

enum PassWordError {invalidPassword, otherErrors}


enum RedirectState {noToken, tokenExpire}

class Authentication with ChangeNotifier {

  Api api = new Api();
   List<UserModel> _getUsers = List<UserModel>();
   List<UserRegModel> _getRegUsers = List<UserRegModel>();

    //  List<AddressBook> _getAddressBook = List<AddressBook>();
    //  List<AddressBook> get getAddressBook => _getAddressBook;
    
         AddressBook _getAddressBook = AddressBook();
     AddressBook get getAddressBook => _getAddressBook;

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final fbLogin = FacebookLogin();

    bool _isLoggedIn = false;
    bool get isLoggedIn => _isLoggedIn;


  RedirectState _redirectState;
 RedirectState get redirectState => _redirectState;


 RegisterState _registerstate = RegisterState.initial; // Initial State of the form
 RegisterState get registerState => _registerstate;


 RegisterError _registerError;
 RegisterError get registerError => _registerError;


 LoginState _loginstate = LoginState.initial;
 LoginState get loginState => _loginstate;

 LoginError _loginError;
 LoginError get loginError => _loginError;

 PassWordError _passWordError;
 PassWordError get getPassWordError => _passWordError;

   bool passwordVisible = true;
   bool get getPasswordVisible => true;

    String _getAuthUser;
    String get getAuthUser => _getAuthUser;

    void setAuthUser()async{
         SharedPreferences prefs = await SharedPreferences.getInstance();
     _getAuthUser = prefs.getString('authName');
     notifyListeners();
    }


 List<UserModel> get getUsers{
  return[..._getUsers];
}




   void toggle(){
     print('toggle from toglle');
       passwordVisible = !passwordVisible;
       notifyListeners();
   }

  Future<bool>  registerUser(String name, email, password, passwordConfirmation, phoneNumber) async {

    try{
       _registerstate = RegisterState.loading; // When User Touches the Sign Up Button, it will Load
      notifyListeners();
      //Pass user info to Api
    var responseJson = await api.registerData(name, email, password, passwordConfirmation, phoneNumber);
    //Check for Errors Using Status Code 400
    if(responseJson.statusCode == 400){
      var encodeFirst = json.encode(responseJson.body);
      var data = jsonDecode(jsonDecode(encodeFirst));
     if(data["message"] == "The password must be at least 6 characters."){
          _registerError = RegisterError.invalidPassword;
            _registerstate = RegisterState.error;
          notifyListeners();
          return false;
          }else if(data["message"] == "The email has already been taken."){
            _registerError = RegisterError.emailTaken;
             _registerstate = RegisterState.error;
           notifyListeners();
            return false;
          }
      }
    // if Status code is not 400 and its 200 then User has been register and save token to shared Pref
      print(responseJson.statusCode);
      var data = json.decode(responseJson.body);
      var usersReg = UserRegModel.fromJson(data);
      var authName = usersReg.data.user.name;
      var authtoken = usersReg.data.token;
      print('this is access token $authtoken');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, authName);
      prefs.setString(key, authtoken);
       _getRegUsers.add(usersReg);
      _registerstate = RegisterState.complete;
      print(prefs.getString('authName'));
       
      notifyListeners();
      return true;
 
    } catch (exception) {
        _registerstate = RegisterState.error;
        _registerError = RegisterError.otherErrors;
        print(exception);
      return false;
  }
  }


Future<bool> loginUser(String email, String password) async {
    try{
       _loginstate = LoginState.loading;
      notifyListeners();
    var responseJson = await api.loginData(email, password);
      var data =  json.decode(responseJson.body);
    //  print(responseJson.statusCode);
    if(responseJson.statusCode == 401){
      if(data["message"] == " Invalid credentials"){
          _loginstate = LoginState.error;
        _loginError = LoginError.invalidEmail;
        notifyListeners();
        return false;
          }
      _loginstate = LoginState.error;
        _loginError = LoginError.invalidEmail;
        notifyListeners();
        return false;
    }
    if(responseJson.statusCode != 200){
      _loginstate = LoginState.error;
      _loginError = LoginError.otherErrors;
      notifyListeners();
      return false;
    }
    // if(responseJson.statusCode == 200 && data["message"] == "Login successfully"){
      print(responseJson.statusCode);
      var result = json.decode(responseJson.body);
       var users = UserModel.fromJson(result);
      //  print("Users are ${users.data.accessToken}");
      var authtoken = users.data.accessToken;
      var authName = users.data.user.name;
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(key, authtoken);
      prefs.setString(keys, authName);
      _loginstate = LoginState.complete;
      _getUsers.add(users);
      notifyListeners();
      return true;
    
 

    } catch (exception) {
      print(exception);
    _loginstate = LoginState.error;
     _loginError = LoginError.otherErrors;
      notifyListeners();
      return false;
  }
}

 logout()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    if(authToken != null){
      prefs.remove('token');
    }
}

// Social Media SignUp

//Google SignUp


Future<FirebaseUser> signUpWithGoogle(BuildContext context)  async{
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: gSA.accessToken,
          idToken: gSA.idToken,
        );

      AuthResult  authResult = await _auth.signInWithCredential(credential);
        var  _user = authResult.user;

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);
    var responseJson = await api.socialSignUp(_user.displayName, _user.email,
     _user.providerId, 'Google');
     print(responseJson.statusCode);
      var data = json.decode(responseJson.body);
      if(responseJson.statusCode == 200 && data['message'] == "Login successfully"){
       var authtoken = data['data']['access_token'];
       print('this is access token $data');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, _user.displayName);
      prefs.setString(key, authtoken);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      Homepage(authName: _user.displayName)), (Route<dynamic> route) => false);
      }
      
        return _user;
    }


//SignUp with Facebook
   Future signUpWithFB(BuildContext context) async {
  final FacebookLoginResult result = await fbLogin.logIn(["email"]);
 switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = json.decode(graphResponse.body);
        // print(profile);
        // print(profile['name']);
        // print(profile['email']);
          AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: token,
          );
        AuthResult  authResult = await _auth.signInWithCredential(credential);
    var  _user = authResult.user;

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);
    var responseJson = await api.socialSignUp(profile['name'], profile['email'],
     profile['id'], 'Facebook');
      var data = json.decode(responseJson.body);
      print(data);
      if(responseJson.statusCode == 200 && data['message'] == "Login successfully"){
        var authtoken = data['data']['access_token'];
       print('this is access token $authtoken');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      
      prefs.setString(keys, profile['name']);
      prefs.setString(key, authtoken);
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      Homepage(authName: profile['name'])), (Route<dynamic> route) => false);
      }   
      if(responseJson.statusCode == 400 && data['data'] == false){
        print('Name is required');
      }
        break;
      case FacebookLoginStatus.cancelledByUser:
        _isLoggedIn = false;
        break;
      case FacebookLoginStatus.error:
         _isLoggedIn = false;
        break;
    }
   
}


// Sign In With Social Media 



    Future<FirebaseUser> signInWithGoogle(BuildContext context)  async{
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

   AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    AuthResult  authResult = await _auth.signInWithCredential(credential);
    var  _user = authResult.user;
    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);
    var responseJson = await api.socialSignIn(
     _user.providerId, 'Google');
     print(responseJson.statusCode);

     print(_user.providerId);
      var data = json.decode(responseJson.body);
      if(responseJson.statusCode == 200 && data['message'] == "Login successfully"){
        var authtoken = data['data']['access_token'];
       print('this is access token $authtoken');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, _user.displayName);
      prefs.setString(key, authtoken);
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      Homepage(authName: _user.displayName)), (Route<dynamic> route) => false);
      }
      
        return _user;
    }



   Future signInFB(BuildContext context) async {
  final FacebookLoginResult result = await fbLogin.logIn(["email"]);
 switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = json.decode(graphResponse.body);
        print(profile);
        // print(profile['name']);
        // print(profile['email']);
          AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: token,
          );
        AuthResult  authResult = await _auth.signInWithCredential(credential);
    var  _user = authResult.user;

    assert(!_user.isAnonymous);
    assert(await _user.getIdToken() != null);

    FirebaseUser currentUser = await _auth.currentUser();

    assert(_user.uid == currentUser.uid);
    var responseJson = await api.socialSignIn(
     profile['id'], 'Facebook');
     print(responseJson.statusCode);
     print(profile['id']);
      var data = json.decode(responseJson.body);
      print(data);
      if(responseJson.statusCode == 200 && data['message'] == "Login successfully"){
        var authtoken = data['data']['access_token'];
       print('this is access token $authtoken');
      final prefs = await SharedPreferences.getInstance();
      final key = 'token';
      final keys = 'authName';
      prefs.setString(keys, profile['name']);
      prefs.setString(key, authtoken);
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      Homepage(authName: profile['name'])), (Route<dynamic> route) => false);
      }   
      if(responseJson.statusCode == 400 && data['data'] == false){
        Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Kindly Register to Login')));
      }
        break;
      case FacebookLoginStatus.cancelledByUser:
         _isLoggedIn = false;
        break;
      case FacebookLoginStatus.error:
        _isLoggedIn = false;
        break;
    }
}

 // ignore: missing_return
 Future<List<AddressBook>> addAddressBook(String firstName, lastName, phoneNumber, mobileNumber, houseNo, street, city, area, deliveryNote) async {

    try{
          SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.addAddress(authToken, firstName, lastName, phoneNumber, mobileNumber, houseNo, street, area, city, deliveryNote);
    // if Status code is not 400 and its 200 then User has been register and save token to shared Pref
      print(responseJson.statusCode);
      if(responseJson.statusCode == 200){
      var data = json.decode(responseJson.body);
          // ignore: unused_local_variable
          var list = data['data'] as List;
      // _getAddressBook = list.map((e) => AddressBook.fromJson(e)).toList();
      notifyListeners();
    }
      // return _getAddressBook;
 
    } catch (exception) {
        print(exception);
      return null;
  }
 }

  Future<AddressBook> getAddressBookDetail() async {

    try{
          SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.getData(authToken, "/user/addresses-book/list");

        if(responseJson.statusCode != 200){
          return null;
        }
    // if Status code is not 400 and its 200 then User has been register and save token to shared Pref
      print(responseJson.statusCode);
      if(responseJson.statusCode == 200){
      var data = json.decode(responseJson.body);
      var result = data['data'][1];
        _getAddressBook = AddressBook.fromJson(result);
       print( _getAddressBook.lastName);
       notifyListeners();
      }
          return _getAddressBook;
    } catch (exception) {
        print(exception);
      return null;
  }
  }

  Future<bool> changePassword(String oldPassword, newPassword,conNewPassword) async {
    try{
                SharedPreferences prefs = await SharedPreferences.getInstance();
    var  authToken = prefs.getString('token');
    var responseJson = await api.changePassword(authToken, oldPassword, newPassword, conNewPassword);
      var data =  json.decode(responseJson.body);
     print(responseJson.statusCode);
    if(responseJson.statusCode == 401){
      if(data["message"] == " Invalid credentials"){
          _passWordError = PassWordError.invalidPassword;
        notifyListeners();
        return false;
          }
      _passWordError = PassWordError.invalidPassword;
        notifyListeners();
        return false;
    }
    if(responseJson.statusCode != 200){
     _passWordError = PassWordError.invalidPassword;
      notifyListeners();
      return false;
    }
    if(responseJson.statusCode == 200)
      notifyListeners();
      return true;

    } catch (exception) {
      print(exception);
    _loginstate = LoginState.error;
     _loginError = LoginError.otherErrors;
      notifyListeners();
      return false;
  }
}

 }

