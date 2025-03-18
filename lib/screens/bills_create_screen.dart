import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:fundsy/utils/constants.dart';

class BillsCreateScreen extends StatefulWidget {
  const BillsCreateScreen({super.key});

  @override
  State<BillsCreateScreen> createState() => _BillsCreateScreenState();
}

class _BillsCreateScreenState extends State<BillsCreateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                FormBuilderDropdown<String>(
                    name: 'category',
                    hint: Text(
                      "Select type",
                      style: TextStyle(color: textColor),
                    ),
                    dropdownColor: secondaryColor,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: secondaryColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      constraints: const BoxConstraints(
                        minHeight: 80,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                    ),
                    items: _buildDropdownItems()),
                FormBuilderTextField(
                  name: "balance",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: secondaryColor,
                    filled: true,
                    label: Text(
                      "Amount",
                      style: TextStyle(color: textColor),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return Utilities.all
        .map((e) => DropdownMenuItem(
            value: e.name,
            child: Row(spacing: 10, children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: primaryColor,
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: e.icon,
                ),
              ),
              Text(e.name)
            ])))
        .toList();
  }
}
