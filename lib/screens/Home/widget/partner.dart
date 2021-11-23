import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nuthoop/helper/config_size.dart';

// ignore: must_be_immutable
class PartnerBar extends StatelessWidget {
  Color color;
  String text;
  String title;
  PartnerBar({this.color, this.text, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.61 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: color,
      ),
      margin: EdgeInsets.only(
        left: 1.3 * SizeConfig.widthMultiplier,
        // 5.0
      ),
      padding: EdgeInsets.only(
        top: 1.0 * SizeConfig.heightMultiplier,
        left: 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: AutoSizeText(
              title,
              minFontSize: 14,
              maxFontSize: 18,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                //  20.0
              ),
            ),
          ),
          SizedBox(
            height: 3.0,
          ),
          Flexible(
            flex: 2,
            child: AutoSizeText(text,
                minFontSize: 12,
                maxFontSize: 14,
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                // softWrap: true,
                style: TextStyle(color: Colors.white
                    // 14.0
                    )),
          )
        ],
      ),
    );
  }
}
