import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.fastfood_rounded),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Eating out",
                    style: TextStyle(
                        fontFamily: "Bassa",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textColor),
                  ),
                  Text(
                    "March 12, 09:20 AM",
                    style: TextStyle(
                        fontFamily: "Bassa",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  ),
                ],
              ),
            ],
          ),
          Text(
            "-\$20.00",
            style: TextStyle(
                fontFamily: "Bassa",
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: textColor),
          )
        ],
      ),
    );
  }
}
