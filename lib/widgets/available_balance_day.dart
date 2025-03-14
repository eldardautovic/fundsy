import 'package:flutter/material.dart';
import 'package:fundsy/providers/transactions_provider.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class AvailableBalanceDay extends StatefulWidget {
  final double balancePerDay;
  const AvailableBalanceDay({super.key, required this.balancePerDay});

  @override
  State<AvailableBalanceDay> createState() => _AvailableBalanceDayState();
}

class _AvailableBalanceDayState extends State<AvailableBalanceDay> {
  late double _spendAmount = 0.0;
  late TransactionProvider _transactionProvider;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _transactionProvider = context.read<TransactionProvider>();

    calculateDailySpending();
  }

  Future<void> calculateDailySpending() async {
    _spendAmount = await _transactionProvider.getDailyTransactions();

    setState(() {
      isLoading = false;
    });
  }

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
                value: (widget.balancePerDay > 0.0 && _spendAmount > 0.0)
                    ? _spendAmount / widget.balancePerDay
                    : 0.0,
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
                "\$$_spendAmount/\$${widget.balancePerDay.toStringAsFixed(2)}",
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
