import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fundsy/routes/route_generator.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fundsy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          hoverColor: Colors.transparent,
          unselectedWidgetColor: secondaryColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            primary: primaryColor,
            secondary: secondaryColor,
            surface: backgroundColor,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: textColor,
                displayColor: textColor,
                fontFamily: "Inter",
              ),
          useMaterial3: true,
        ),
        initialRoute: getInitialPage(),
        routes: routes);
  }

  String getInitialPage() => AppRoutes.onBoarding;
  // String getInitialPage() => initScreen == 0 || initScreen == null
  //     ? AppRoutes.onBoarding
  //     : AppRoutes.home;
}
