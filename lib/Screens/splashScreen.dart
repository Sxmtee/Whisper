import 'package:flutter/material.dart';
import 'package:whisper/Widgets/opacityBg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: OpacityBg(context, Container()),
    ));
  }
}
