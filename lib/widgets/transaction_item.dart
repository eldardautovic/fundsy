import 'package:flutter/material.dart';
import 'package:fundsy/models/financial_item.dart';
import 'package:intl/intl.dart';

import '../utils/colors.dart';

class TransactionItem extends StatefulWidget {
  final bool checkable;
  final FinancialItem item;
  final bool completed;

  const TransactionItem(
      {super.key,
      this.checkable = false,
      required this.item,
      this.completed = false});

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  bool completed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    completed = widget.completed;
  }

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
                        .format(widget.item.createdAt),
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
                  value: widget.completed,
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
