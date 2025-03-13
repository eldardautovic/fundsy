import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TransactionItem extends StatefulWidget {
  bool checkable;

  TransactionItem({super.key, this.checkable = false});

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
                    "Eating out",
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
                    "March 12, 09:20 AM",
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
                "-\$20.00",
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
