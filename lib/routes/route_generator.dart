import 'package:flutter/material.dart';
import 'package:fundsy/layouts/master_layout.dart';
import 'package:fundsy/screens/bills_create_screen.dart';
import 'package:fundsy/screens/bills_screen.dart';
import 'package:fundsy/screens/buy_screen.dart';
import 'package:fundsy/screens/home_screen.dart';
import 'package:fundsy/screens/onboarding_screen.dart';
import 'package:fundsy/screens/profile_screen.dart';
import 'package:fundsy/screens/wallet_screen.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.onBoarding,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MasterLayout(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.bills,
              builder: (context, state) => BillsScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.addBill,
                  name: AppRoutes.addBill,
                  builder: (context, state) => BillsCreateScreen(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.buy,
              builder: (context, state) => BuyScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.wallet,
              builder: (context, state) => WalletScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
