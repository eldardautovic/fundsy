import 'package:flutter/material.dart';
import 'package:fundsy/routes/route_generator.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fundsy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
          secondary: secondaryColor,
          surface: backgroundColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: getInitialPage(),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const Placeholder(),
    );
  }

  String getInitialPage() => initScreen == 0 || initScreen == null
      ? AppRoutes.onBoarding
      : AppRoutes.home;
}
