import 'package:flutter/material.dart';
import 'package:fundsy/screens/bills_screen.dart';
import 'package:fundsy/screens/home_screen.dart';
import 'package:fundsy/screens/onboarding_screen.dart';
import 'package:fundsy/screens/profile_screen.dart';
import 'package:fundsy/screens/wallet_screen.dart';
import 'package:fundsy/utils/colors.dart';

import 'routes.dart';

/// route_generator.dart
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case AppRoutes.onBoarding:
        return buildRoute(const OnboardingScreen(), settings: settings);
      case AppRoutes.wallet:
        return buildRoute(const WalletScreen(), settings: settings);
      case AppRoutes.bills:
        return buildRoute(const BillsScreen(), settings: settings);
      case AppRoutes.profile:
        return buildRoute(const ProfileScreen(), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
