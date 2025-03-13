import 'package:flutter/material.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:fundsy/widgets/remaining_bills.dart';
import 'package:fundsy/widgets/transaction_item.dart';

import '../widgets/header_widget.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(
            title: "Bills", description: "Overview of your monthly bills"),
        _buildAddBillButton(),
        RemainingBills(),
        _buildBills()
      ],
    );
  }

  Widget _buildAddBillButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: TextStyle(color: backgroundColor),
                foregroundColor: backgroundColor),
            child: Text("Add bill"),
          ),
        ],
      ),
    );
  }

  Widget _buildBills() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          TransactionItem(checkable: true),
          TransactionItem(checkable: true),
          TransactionItem(checkable: true)
        ],
      ),
    );
  }
}
