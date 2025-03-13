import 'package:flutter/material.dart';
import 'package:fundsy/layouts/master_layout.dart';
import 'package:fundsy/screens/bills_screen.dart';
import 'package:fundsy/screens/onboarding_screen.dart';
import 'package:fundsy/screens/profile_screen.dart';
import 'package:fundsy/screens/wallet_screen.dart';

import 'routes.dart';

/// route_generator.dart
Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.home: (context) => MasterLayout(),
  AppRoutes.onBoarding: (context) => OnboardingScreen(),
  AppRoutes.bills: (context) => BillsScreen(),
  AppRoutes.profile: (context) => ProfileScreen(),
  AppRoutes.wallet: (context) => WalletScreen(),
};
