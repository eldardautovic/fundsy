import 'package:flutter/material.dart';

import '../utils/colors.dart';

class RemainingBills extends StatelessWidget {
  final double leftoverBills;
  const RemainingBills({super.key, required this.leftoverBills});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: secondaryColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Remaining bills:",
              style: TextStyle(
                  fontFamily: "Bassa",
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "For this month:",
                  style: TextStyle(
                      fontFamily: "Bassa",
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "\$${leftoverBills.toStringAsFixed(2)}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: "Bassa",
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
