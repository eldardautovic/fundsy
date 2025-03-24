import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:fundsy/providers/transactions_provider.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/widgets/transaction_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class TransactionLogs extends StatefulWidget {
  final bool areAllIncluded;
  const TransactionLogs({super.key, this.areAllIncluded = false});

  @override
  State<TransactionLogs> createState() => _TransactionLogsState();
}

class _TransactionLogsState extends State<TransactionLogs> {
  late TransactionProvider _transactionProvider;

  late StreamSubscription _subscription;

  late List<Transaction> _list;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _transactionProvider = context.read<TransactionProvider>();
    _subscription = _transactionProvider.onTransactionsChanged.listen((_) {
      // Refresh transactions when the stream emits
      _refreshTransactions();
    });

    // Initial load
    _refreshTransactions();

    initLogs();
  }

  void _refreshTransactions() async {
    final transactions =
        await TransactionProvider().getTransactions(widget.areAllIncluded);
    setState(() {
      _list = transactions;
    });
  }

  Future<void> initLogs() async {
    _list = await _transactionProvider.getTransactions(widget.areAllIncluded);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _subscription.cancel(); // Don't forget to cancel subscription
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true || _list.isEmpty) {
      return SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(), _buildTransactions()],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Transactions",
          style: TextStyle(
              fontFamily: "Bassa", fontSize: 15, fontWeight: FontWeight.w500),
        ),
        if (widget.areAllIncluded == false)
          GestureDetector(
            onTap: () {
              context.go(AppRoutes.wallet);
            },
            child: Text(
              "See all",
              style: TextStyle(
                  fontFamily: "Bassa",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: primaryColor,
                  decoration: TextDecoration.underline,
                  decorationColor: primaryColor),
            ),
          ),
      ],
    );
  }

  Widget _buildTransactions() {
    return Column(
      children: [
        ..._list.map((transact) => TransactionItem(
              item: transact,
              checkable: false,
              id: transact.id,
            ))
      ],
    );
  }
}
