import 'dart:async';
import 'package:accurate_task/core/routing/routes_manager.dart';
import 'package:accurate_task/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay of 3 seconds before navigating to the next screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backGroundColorScaffold,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Accurate",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: ColorManager.primaryColor),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorManager.backGroundButton),
            ),
          ],
        ),
      ),
    );
  }
}
