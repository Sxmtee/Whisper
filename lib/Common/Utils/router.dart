import 'package:flutter/material.dart';
import 'package:whisper/Common/Widgets/error_screen.dart';
import 'package:whisper/Features/Auth/screens/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This Page Does Not Exist"),
        ),
      );
  }
}
