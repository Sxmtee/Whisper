import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whisper/Controllers/authController.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Utils/navigate.dart';
import 'package:whisper/Widgets/opacityBg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 6), () {
      NavigateToPage(context, const SignInScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: OpacityBg(
          context,
          Container(
            child: Center(child: Text("SPLASHSCREEN")),
          )),
    ));
  }
}
