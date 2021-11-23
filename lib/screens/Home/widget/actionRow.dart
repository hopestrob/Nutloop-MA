import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';

Row buildActionbar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        margin: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => {print('Hello')},
              child: CircleAvatar(
                radius: 25,
                backgroundColor: kBrandColor,
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hi Josh,',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: kBrandColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
