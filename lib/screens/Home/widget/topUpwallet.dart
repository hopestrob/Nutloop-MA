import 'package:flutter/material.dart';
import 'package:nuthoop/screens/Auth/constants.dart';
import '../../../helper/config_size.dart';

void topUpSuccessBottomSheet(
    BuildContext context, String transactionRef, amount) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: IntrinsicHeight(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Top-up success',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 2,
                        child: Icon(
                          Icons.check_circle_outline_outlined,
                          color: Color(0xff80C46D).withOpacity(0.4),
                          size: 120,
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your Top-up is successful',
                            style: TextStyle(
                              color: kBrandColor,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'REF:  $transactionRef',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'AMOUNT',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '₦$amount',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          //300
                          width: 83.33 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                              color: Color(0xff80C46D),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: TextButton(
                            onPressed: () async {
                              Navigator.of(context)..pop()..pop();
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
