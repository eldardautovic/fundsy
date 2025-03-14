import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AvailableBalanceDay extends StatelessWidget {
  final double balancePerDay;
  const AvailableBalanceDay({super.key, required this.balancePerDay});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Money left to spend today:",
            style: TextStyle(fontFamily: "Bassa", fontSize: 15),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 15,
            child: Positioned.fill(
              child: LinearProgressIndicator(
                value: 0.7,
                color: primaryColor,
                backgroundColor: secondaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "\$10.04/\$${balancePerDay.toStringAsFixed(2)}",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: "Bassa",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: textColor.withAlpha(230)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
