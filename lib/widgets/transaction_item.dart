import 'package:flutter/material.dart';
import 'package:fundsy/models/transaction.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class TransactionItem extends StatefulWidget {
  final bool checkable;
  final Transaction transaction;

  const TransactionItem(
      {super.key, this.checkable = false, required this.transaction});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  bool completed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.fastfood_rounded),
                ),
              ),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.transaction.category,
                    style: TextStyle(
                        fontFamily: "Bassa",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        decoration: completed == true
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        decorationColor: textColor),
                  ),
                  Text(
                    DateFormat('MMMM dd, hh:mm a')
                        .format(widget.transaction.createdAt),
                    style: TextStyle(
                        fontFamily: "Bassa",
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        decoration: completed == true
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
                "-\$${widget.transaction.balance.toStringAsFixed(2)}",
                style: TextStyle(
                    fontFamily: "Bassa",
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    decoration: completed == true
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: textColor),
              ),
              if (widget.checkable)
                Checkbox(
                  shape: const CircleBorder(),
                  checkColor: secondaryColor,
                  value: completed,
                  side: BorderSide(width: 0),
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
                    setState(() {
                      completed = value ?? false;
                    });
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
