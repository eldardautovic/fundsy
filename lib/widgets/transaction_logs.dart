import 'package:flutter/material.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:fundsy/providers/transactions_provider.dart';
import 'package:fundsy/widgets/transaction_item.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class TransactionLogs extends StatefulWidget {
  const TransactionLogs({super.key});

  @override
  State<TransactionLogs> createState() => _TransactionLogsState();
}

class _TransactionLogsState extends State<TransactionLogs> {
  late TransactionProvider _transactionProvider;

  late List<Transaction> _list;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _transactionProvider = context.read<TransactionProvider>();

    initLogs();
  }

  Future<void> initLogs() async {
    _list = await _transactionProvider.getTransactions();

    setState(() {
      isLoading = false;
    });
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
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Transactions",
          style: TextStyle(
              fontFamily: "Bassa", fontSize: 15, fontWeight: FontWeight.w500),
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
    );
  }

  Widget _buildTransactions() {
    return Column(
      children: [
        ..._list.map((transact) => TransactionItem(
              transaction: transact,
              checkable: false,
            ))
      ],
    );
  }
}
