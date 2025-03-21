import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fundsy/database/database.dart';
import 'package:fundsy/providers/transactions_provider.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:fundsy/utils/constants.dart';
import 'package:fundsy/widgets/header_widget.dart';
import 'package:provider/provider.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late TransactionProvider _transactionProvider;

  @override
  void initState() {
    super.initState();

    _transactionProvider = context.read<TransactionProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWidget(
                    title: "Buy", description: "Think about spending?"),
                SizedBox(height: 20),
                ..._buildFormInputs(),
                _save()
              ],
            )),
      ),
    );
  }

  Future<void> saveBill() async {
    _formKey.currentState?.saveAndValidate();

    if (_formKey.currentState?.isValid == true) {
      final balance = _formKey.currentState?.value['balance'] as double;

      if (user.perDaySpending < balance) {
        final bool? confirm = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: secondaryColor,
              title: Text('Warning'),
              content: Text(
                  'This transaction is bigger than your daily spending limit. Are you sure you want to continue?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        );

        if (confirm != true) {
          return;
        }
      }

      await _transactionProvider.insert({
        'balance': balance,
        'category': _formKey.currentState?.value['category'],
        'created_at': DateTime.now().toIso8601String()
      });

      _formKey.currentState?.reset();
    }
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
          child: Text("Buy"),
        ));
  }

  List<DropdownMenuItem<String>> _buildDropdownItems() {
    return Categories.all
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
