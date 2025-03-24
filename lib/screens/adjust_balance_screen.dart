import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fundsy/database/database.dart';
import 'package:fundsy/providers/user_provider.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AdjustBalanceScreen extends StatefulWidget {
  const AdjustBalanceScreen({super.key});

  @override
  State<AdjustBalanceScreen> createState() => _AdjustBalanceScreenState();
}

class _AdjustBalanceScreenState extends State<AdjustBalanceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UserProvider _userProvider;

  late Map<String, dynamic> _initialValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _userProvider = context.read<UserProvider>();

    _initialValue = {"balance": user.balance};
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
              content: Text('You will adjust your balance to $balance ?'),
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

      await _userProvider.update({'balance': balance});

      _formKey.currentState?.reset();

      context.go(AppRoutes.wallet);
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
              children: [_buildFormInput(), _save()],
            )),
      ),
    );
  }

  Widget _buildFormInput() {
    return FormBuilderTextField(
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
    );
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
          child: Text("Adjust balance"),
        ));
  }
}
