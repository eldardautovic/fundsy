import 'package:flutter/material.dart';
import 'package:fundsy/screens/bills_screen.dart';
import 'package:fundsy/screens/buy_screen.dart';
import 'package:fundsy/screens/home_screen.dart';
import 'package:fundsy/screens/profile_screen.dart';
import 'package:fundsy/screens/wallet_screen.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_provider.dart';

class MasterLayout extends StatefulWidget {
  const MasterLayout({super.key});

  @override
  State<MasterLayout> createState() => _MasterLayoutState();
}

class _MasterLayoutState extends State<MasterLayout> {
  final List<Widget> _screens = [
    HomeScreen(),
    BillsScreen(),
    BuyScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(24),
            child: _screens[navigationProvider.currentIndex]),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: secondaryColor,
          ),
          child: BottomNavigationBar(
            backgroundColor: secondaryColor,
            unselectedItemColor: textColor,
            selectedItemColor: primaryColor,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: textColor),
            unselectedLabelStyle: TextStyle(color: textColor),
            currentIndex: navigationProvider.currentIndex,
            onTap: (index) => navigationProvider.setCurrentIndex(index),
            items: _buildNavItems(navigationProvider.currentIndex),
          ),
        ));
  }

  List<BottomNavigationBarItem> _buildNavItems(int currentIndex) {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(Icons.receipt_rounded), label: 'Bills'),
      BottomNavigationBarItem(
        icon: Container(
          decoration: BoxDecoration(
            color: currentIndex == 2 ? primaryColor : textColor,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.shopping_bag_rounded, color: backgroundColor),
          ),
        ),
        label: "",
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet_rounded), label: 'Wallet'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), label: 'Profile'),
    ];
  }
}
