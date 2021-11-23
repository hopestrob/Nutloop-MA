import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuthoop/model/subject.dart';
import 'package:nuthoop/provider/auth_provider.dart';

// import 'package:nuthoop/provider/cart.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import 'package:nuthoop/screens/Auth/widget/textfield.dart';
import 'package:nuthoop/screens/Home/widget/displaymessage.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key key}) : super(key: key);

  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var currentSelectedValue;

  Future<void> _makephoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          displayMessage('Could not Dail Number try again later'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            centerTitle: true,
            title: Text(
              'Write Us',
              style: TextStyle(color: kBrandColor),
            ),
            backgroundColor: greyColor7,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(children: [
            Expanded(
                child: Container(
              color: greyColor7,
              child: ListView(children: <Widget>[
                CustomTextField(
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  hitText: "Name",
                ),
                SizedBox(
                  height: 10.0,
                ),
                CustomTextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  hitText: "Phone",
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hitText: "Email",
                ),
                Consumer<Authentication>(
                  builder: (_, subjects, child) => Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 20.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: subjects.getReadyState == true
                                    ? Text("Select your Subject")
                                    : Text('loading..'),
                                value: currentSelectedValue,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSelectedValue = newValue;
                                  });
                                  print(currentSelectedValue);
                                },
                                items: subjects.getsubjectContact
                                    .map((SubjectModel value) {
                                  return DropdownMenuItem<String>(
                                    value: value.id.toString(),
                                    child: Text(value.name.toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: messageController,
                    decoration: new InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey)),
                      labelText: 'Enter Message here..',
                      labelStyle: TextStyle(color: kPrimaryColor, fontSize: 15),
                      enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey)),
                      contentPadding: EdgeInsets.only(bottom: 20.0),
                      focusedBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.grey)),
                    ),
                    autofocus: false,
                    keyboardType: TextInputType.multiline,
                    maxLength: null,
                    maxLines: null,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    // shape: RoundedRectangleBorder(
                    //     borderRadius:
                    //         BorderRadius.all(
                    //             Radius.circular(
                    //                 20.0))),
                    // color: kBrandColor,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        primary: kBrandColor),
                    onPressed: () async {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //        backgroundColor: kBrandColor,
                      //     content: Text('A SnackBar has been shown.'),
                      //   ),
                      // );

                      if (!await context
                          .read<Authentication>()
                          .sendContactMessage(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                              messageController.text,
                              int.parse(currentSelectedValue.toString()))) {
                        switch (
                            context.read<Authentication>().sendContactState) {
                          case SendContactState.initial:
                          case SendContactState.loading:
                          case SendContactState.complete:
                          case SendContactState.error:
                            return
                                // print(
                                //     'this is the error ${Provider.of<Authentication>(context, listen: false).contactError.toString()}');
                                ScaffoldMessenger.of(context).showSnackBar(
                                    displayMessage(Provider.of<Authentication>(
                                            context,
                                            listen: false)
                                        .contactError
                                        .toString()));
                        }
                      } else {
                        nameController.clear();
                        emailController.clear();
                        phoneController.clear();
                        messageController.clear();
                        return ScaffoldMessenger.of(context).showSnackBar(
                            displayMessage(
                                'Message sent.. We will get back to you..thank you'));
                      }
                    },
                    child: sendContactMessgae(context),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      AutoSizeText('You still have a question?',
                          minFontSize: 22,
                          maxFontSize: 24,
                          maxLines: 2,
                          style: TextStyle(color: kBrandColor)),
                      SizedBox(
                        height: 5.0,
                      ),
                      AutoSizeText(
                          'if you cannot find question in our FAQ, you can always contact us. We willl answer to you shortly!',
                          minFontSize: 10,
                          maxFontSize: 12,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black)),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 8,
                            child: Column(
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 8.5,
                                    height:
                                        MediaQuery.of(context).size.height / 16,
                                    color: kBrandColor.withOpacity(0.5),
                                    margin:
                                        EdgeInsets.only(top: 5.0, bottom: 3.0),
                                    padding:
                                        EdgeInsets.only(top: 3.0, bottom: 3.0),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _makephoneCall('tel://01 454 4989');
                                        });
                                      },
                                      icon: Icon(
                                        Icons.phone,
                                        color: kPrimaryColor,
                                      ),
                                    )),
                                SizedBox(
                                  height: 2.0,
                                ),
                                AutoSizeText('01 454 4989',
                                    minFontSize: 9,
                                    maxFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                                AutoSizeText('We are always happy to help!',
                                    minFontSize: 9,
                                    maxFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.grey[300],
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 8,
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 8.5,
                                  height:
                                      MediaQuery.of(context).size.height / 16,
                                  color: kBrandColor.withOpacity(0.5),
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 3.0),
                                  padding:
                                      EdgeInsets.only(top: 3.0, bottom: 3.0),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _makephoneCall(
                                              'mailto:hello@nuthoop.com?subject=Email from Nuthoop App e&body=This is Body of Email');
                                        });
                                      },
                                      icon: Icon(
                                        Icons.email,
                                        color: kPrimaryColor,
                                      )),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                AutoSizeText('hello@nuthoop.com',
                                    minFontSize: 9,
                                    maxFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                                AutoSizeText('Best way to get answer faster!',
                                    minFontSize: 9,
                                    maxFontSize: 10,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )
              ]),
            )),
          ])),
    );
  }
}

// ignore: missing_return
Widget sendContactMessgae(BuildContext context) {
  switch (context.watch<Authentication>().sendContactState) {
    case SendContactState.initial:
      return AutoSizeText(
        'Send',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case SendContactState.loading:
      return Row(children: [
        CupertinoActivityIndicator(),
        AutoSizeText(
          'Sending...',
          minFontSize: 10,
          maxFontSize: 12,
          maxLines: 2,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ]);
    case SendContactState.error:
      return AutoSizeText(
        'Send',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
        ),
      );
    case SendContactState.complete:
      return AutoSizeText(
        'Send',
        minFontSize: 10,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
  }
  return AutoSizeText(
    'Send',
    minFontSize: 10,
    maxFontSize: 12,
    maxLines: 2,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  );
}

line(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.35,
        color: greyColor4,
      ),
    );
makeListTile(Widget icon, String title) => ListTile(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      // decoration: new BoxDecoration(
      //     border: new Border(
      //         right: new BorderSide(
      //             width: 1.0, color: Colors.black87))),
      child: icon,
    ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
    ),
    trailing:
        Icon(Icons.keyboard_arrow_right, color: Colors.black54, size: 30.0));
