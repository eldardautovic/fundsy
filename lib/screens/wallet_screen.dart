import 'package:flutter/material.dart';
import 'package:fundsy/widgets/header_widget.dart';
import 'package:fundsy/widgets/transaction_logs.dart';
import 'package:fundsy/widgets/wallet_information.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(title: "Wallet", description: "Your personal wallet."),
            WalletInformation(),
            TransactionLogs(areAllIncluded: true)
          ],
        ),
      ),
    );
  }
}
