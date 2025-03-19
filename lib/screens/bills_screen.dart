import 'package:flutter/material.dart';
import 'package:fundsy/models/bill.dart';
import 'package:fundsy/providers/bills_provider.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/widgets/remaining_bills.dart';
import 'package:fundsy/widgets/transaction_item.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widgets/header_widget.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  late BillsProvider _billsProvider;

  late double _leftoverBillsAmount;
  late List<Bill> _list;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _billsProvider = context.read<BillsProvider>();
    initBills();
  }

  Future initBills() async {
    _list = await _billsProvider.getBills();
    _leftoverBillsAmount = await _billsProvider.getLeftoverBillsAmount();

    print(_leftoverBillsAmount);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return CircularProgressIndicator();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(
            title: "Bills", description: "Overview of your monthly bills"),
        _buildAddBillButton(),
        RemainingBills(
          leftoverBills: _leftoverBillsAmount,
        ),
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
            onPressed: () {
              context.goNamed(AppRoutes.addBill);
            },
            child: Text("Add bill"),
          ),
        ],
      ),
    );
  }

  Widget _buildBills() {
    if (isLoading == false && _list.isEmpty) {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Text("There is no bills for this month."));
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: _list
            .map(
              (e) => TransactionItem(
                item: e,
                checkable: true,
              ),
            )
            .toList(),
      ),
    );
  }
}
