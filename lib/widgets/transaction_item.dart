import 'package:flutter/material.dart';
import 'package:fundsy/models/bill.dart';
import 'package:fundsy/models/financial_item.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:fundsy/providers/bills_provider.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';

class TransactionItem extends StatefulWidget {
  final bool checkable;

  final int id;
  final FinancialItem item;
  final bool completed;
  final Function? onComplete;

  const TransactionItem(
      {super.key,
      this.checkable = false,
      required this.item,
      this.completed = false,
      this.onComplete,
      required this.id});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  bool completed = false;

  late BillsProvider _billsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    completed = widget.completed;

    _billsProvider = context.read<BillsProvider>();
  }

  Future<void> markAsCompleted(bool? value) async {
    Bill tempBill = widget.item as Bill;

    tempBill.completed = !widget.completed;

    await _billsProvider.complete(tempBill, widget.id);

    widget.onComplete!();

    setState(() {
      completed = value ?? false;
    });
  }

  void redirectToEdit() {
    if (widget.checkable) {
      Bill tempBill = widget.item as Bill;

      tempBill.completed = widget.completed;
      tempBill.id = widget.id;

      context.goNamed(AppRoutes.editBill, extra: tempBill);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        redirectToEdit();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(builder: (context) {
                      if (widget.item is Bill) {
                        final bill = widget.item as Bill;
                        final utility = UtilityEnum.fromName(bill.category);
                        return utility.icon; // Koristimo utility.icon
                      } else {
                        final transaction = widget.item as Transaction;
                        final category =
                            CategoryEnum.fromName(transaction.category);
                        return category.icon; // Koristimo utility.icon
                      }
                    }),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.category,
                      style: TextStyle(
                          fontFamily: "Bassa",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                          decoration: completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: textColor),
                    ),
                    Text(
                      DateFormat('MMMM dd, hh:mm a')
                          .format(DateTime.parse(widget.item.createdAt)),
                      style: TextStyle(
                          fontFamily: "Bassa",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: textColor,
                          decoration: completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          decorationColor: textColor),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "-\$${widget.item.balance.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontFamily: "Bassa",
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: textColor),
                ),
                if (widget.checkable)
                  Checkbox(
                    shape: const CircleBorder(),
                    checkColor: secondaryColor,
                    value: completed,
                    side: const BorderSide(width: 0),
                    fillColor: WidgetStateColor.resolveWith(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return primaryColor;
                        }
                        return secondaryColor;
                      },
                    ),
                    activeColor: primaryColor,
                    onChanged: (value) {
                      markAsCompleted(value);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
