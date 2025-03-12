import 'package:flutter/material.dart';
import 'package:fundsy/routes/routes.dart';
import 'package:fundsy/utils/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [..._buildImages(), _buildBottomSheet()],
    ));
  }

  List<Widget> _buildImages() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return [
      Positioned(
        top: screenHeight * 0.05,
        left: screenWidth * 0.10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
          child: Image.asset(
            "assets/images/onboarding-1.png",
            fit: BoxFit.cover,
            width: screenWidth * 0.25,
            height: screenHeight * 0.20,
          ),
        ),
      ),
      Positioned(
        top: screenHeight * 0.06,
        right: screenWidth * 0.10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
          child: Image.asset(
            "assets/images/onboarding-4.png",
            fit: BoxFit.cover,
            width: screenWidth * 0.35,
            height: screenHeight * 0.25,
          ),
        ),
      ),
      Positioned(
        top: screenHeight * 0.26,
        left: screenWidth * 0.10,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
          child: Image.asset(
            "assets/images/onboarding-2.png",
            fit: BoxFit.cover,
            width: screenWidth * 0.35,
            height: screenHeight * 0.30,
          ),
        ),
      ),
      Positioned(
        top: screenHeight * 0.32,
        right: screenWidth * 0.15,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenWidth * 0.15),
          child: Image.asset(
            "assets/images/onboarding-3.png",
            fit: BoxFit.cover,
            width: screenWidth * 0.25,
            height: screenHeight * 0.22,
          ),
        ),
      ),
    ];
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        height: MediaQuery.of(context).size.height / 2.4,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Saving money made simple",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    "Stay in control of your finances ensuring your purchases won't impact your bill payments for the month.",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontFamily: "Bassa",
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () => {
                                Navigator.pushReplacementNamed(
                                    context, AppRoutes.home)
                              },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              textStyle: TextStyle(color: backgroundColor),
                              foregroundColor: backgroundColor),
                          child: Text(
                            "Let's go",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                          )),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
