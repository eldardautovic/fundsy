import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundsy/models/user.dart';
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

  late StreamSubscription _subscription;

  late TransactionProvider _transactionProvider;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _transactionProvider = context.read<TransactionProvider>();
    _subscription = _transactionProvider.onTransactionsChanged.listen((_) {
      // Refresh transactions when the stream emits
      _refreshTransactions();
    });

    _refreshTransactions();
  }

  void _refreshTransactions() async {
    _spendAmount = await _transactionProvider.getDailyTransactions();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    final isLowBalance = user.balance < 10;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLowBalance || _spendAmount > widget.balancePerDay) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.amber,
                  size: 35,
                ),
                const SizedBox(width: 10),
                Text(
                  isLowBalance
                      ? "Low balance, avoid payments."
                      : "You spent your daily spending balance.",
                  style: TextStyle(
                    fontFamily: "Bassa",
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
          const Text(
            "Money left to spend today:",
            style: TextStyle(fontFamily: "Bassa", fontSize: 15),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 15,
            child: LinearProgressIndicator(
              value: calculatePercentage(),
              color: _spendAmount > widget.balancePerDay
                  ? errorColor
                  : primaryColor,
              backgroundColor: secondaryColor,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "\$${widget.balancePerDay <= 0 ? "0.00" : _spendAmount}/\$${widget.balancePerDay <= 0 ? "0.00" : widget.balancePerDay.toStringAsFixed(2)}",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: "Bassa",
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: textColor.withAlpha(230),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double calculatePercentage() {
    return (widget.balancePerDay > 0.0 && _spendAmount > 0.0)
        ? _spendAmount / widget.balancePerDay
        : 0.0;
  }
}
