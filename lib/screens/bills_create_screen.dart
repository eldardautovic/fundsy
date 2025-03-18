import 'package:flutter/material.dart';

class BillsCreateScreen extends StatefulWidget {
  const BillsCreateScreen({super.key});

  @override
  State<BillsCreateScreen> createState() => _BillsCreateScreenState();
}

class _BillsCreateScreenState extends State<BillsCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(children: [Text("Add a bill screen")]);
  }
}
