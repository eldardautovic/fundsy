import 'package:flutter/material.dart';
import 'package:fundsy/widgets/transaction_item.dart';

import '../utils/colors.dart';

class TransactionLogs extends StatefulWidget {
  const TransactionLogs({super.key});

  @override
  State<TransactionLogs> createState() => _TransactionLogsState();
}

class _TransactionLogsState extends State<TransactionLogs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                    fontFamily: "Bassa",
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "See all",
                style: TextStyle(
                    fontFamily: "Bassa",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: primaryColor),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
          TransactionItem(),
        ],
      ),
    );
  }
}
