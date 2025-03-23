import 'package:flutter/material.dart';
import 'package:fundsy/database/database.dart';
import 'package:fundsy/utils/colors.dart';

class WalletInformation extends StatefulWidget {
  const WalletInformation({super.key});

  @override
  State<WalletInformation> createState() => _WalletInformationState();
}

class _WalletInformationState extends State<WalletInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(20),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  Icons.wallet,
                  color: secondaryColor,
                ),
              ),
              Text(
                "Cash",
                style: TextStyle(
                    fontFamily: "Bassa",
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
            ],
          ),
          Text(
            "\$ ${user.balance.toStringAsFixed(2)}",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          )
        ],
      ),
    );
  }
}
