import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fundsy/models/bill.dart';
import 'package:fundsy/providers/bills_provider.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:fundsy/utils/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class BillsCreateScreen extends StatefulWidget {
  final Bill? bill;
  final int? id;
  const BillsCreateScreen({super.key, this.bill, this.id});

  @override
  State<BillsCreateScreen> createState() => _BillsCreateScreenState();
}

class _BillsCreateScreenState extends State<BillsCreateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late BillsProvider _billsProvider;

  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initialValue = {
      'completed': widget.bill?.completed ?? 0,
      'balance': widget.bill?.balance,
      'category': widget.bill?.category,
      'created_at': widget.bill?.createdAt
    };

    _billsProvider = context.read<BillsProvider>();
  }

  Future<void> saveBill() async {
    _formKey.currentState?.saveAndValidate();

    if (_formKey.currentState?.isValid == true) {
      if (widget.bill == null) {
        await _billsProvider.insert({
          'completed': 0,
          'balance': _formKey.currentState?.value['balance'],
          'category': _formKey.currentState?.value['category'],
          'created_at': DateTime.now().toIso8601String()
        });
      } else {
        await _billsProvider.update({
          'completed': widget.bill!.completed ? 1 : 0,
          'balance': _formKey.currentState?.value['balance'],
          'category': _formKey.currentState?.value['category'],
        }, widget.id!);
      }

      context.replace(AppRoutes.bills);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: FormBuilder(
            key: _formKey,
            initialValue: _initialValue,
            child: Column(
              children: [..._buildFormInputs(), _save()],
            )),
      ),
    );
  }

  List<Widget> _buildFormInputs() {
    return [
      FormBuilderDropdown<String>(
          name: 'category',
          hint: Text(
            "Select type",
            style: TextStyle(color: textColor),
          ),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
          ]),
          initialValue: _initialValue['category'],
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
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
          items: _buildDropdownItems()),
      FormBuilderTextField(
        name: "balance",
        keyboardType: TextInputType.number,
        initialValue: _initialValue['balance']?.toString(),
        validator: FormBuilderValidators.compose(
            [FormBuilderValidators.required(), FormBuilderValidators.float()]),
        valueTransformer: (value) {
          if (value != null) {
            return double.tryParse(value);
          }
        },
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
    ];
  }

  Widget _save() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ElevatedButton(
          onPressed: saveBill,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            textStyle: TextStyle(color: textColor),
            foregroundColor: backgroundColor,
            minimumSize: Size(MediaQuery.of(context).size.width, 50),
            shadowColor: Colors.transparent,
          ),
          child: Text(widget.bill != null ? "Save" : "Add a bill"),
        ));
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
