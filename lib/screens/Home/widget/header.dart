import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';

header(BuildContext context, String title) => InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          padding: EdgeInsets.only(top: 8.0),
          margin: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios, size: 30, color: greyColor2),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3.5,
              ),
              Text(
                title,
                style:
                    TextStyle(color: kBrandColor, fontWeight: FontWeight.bold),
              ),
            ],
          )),
    );
