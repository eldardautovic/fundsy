import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String description;

  const HeaderWidget(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Bassa",
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
