import 'package:flutter/material.dart';
import 'package:fundsy/routes/routes.dart';
import '../utils/colors.dart';

class BalanceCard extends StatelessWidget {
  double balance;
  BalanceCard({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your balance",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Bassa",
                  fontWeight: FontWeight.w500,
                  color: secondaryColor),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "\$$balance",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: secondaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.wallet);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                textStyle: TextStyle(color: textColor),
                foregroundColor: textColor,
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shadowColor: Colors.transparent,
              ),
              child: Text("Add money"),
            )
          ],
        ),
      ),
    );
  }
}
