import 'package:flutter/material.dart';
import 'package:fundsy/widgets/available_balance_day.dart';
import 'package:fundsy/widgets/balance_card.dart';
import 'package:fundsy/widgets/header_widget.dart';
import 'package:fundsy/widgets/transaction_logs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(
                title: DateTime.now().hour <= 12
                    ? "Good morning"
                    : "Good afternoon",
                description: "Welcome back to Fundsy"),
            BalanceCard(),
            AvailableBalanceDay(),
            TransactionLogs()
          ],
        ),
      ),
    );
  }
}
