import 'package:flutter/material.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/navigation_provider.dart';

class MasterLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MasterLayout(this.navigationShell, {super.key});

  @override
  State<MasterLayout> createState() => _MasterLayoutState();
}

class _MasterLayoutState extends State<MasterLayout> {
  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
        body: Container(
            margin: EdgeInsets.all(24), child: widget.navigationShell),
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
            currentIndex: widget.navigationShell.currentIndex,
            onTap: _onTap,
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
            color: widget.navigationShell.currentIndex == AppRoutes.buyIndex
                ? primaryColor
                : textColor,
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

  void _onTap(index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
