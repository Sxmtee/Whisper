import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:whisper/Common/Widgets/generalWidgets/error_screen.dart';
import 'package:whisper/Features/Auth/screens/login_screen.dart';
import 'package:whisper/Features/Auth/screens/otp_screen.dart';
import 'package:whisper/Features/Auth/screens/userinfo_screen.dart';
import 'package:whisper/Features/Views/screens/confirm_status.dart';
import 'package:whisper/Features/Views/screens/mobile_chat_screen.dart';
import 'package:whisper/Features/Views/screens/select_contact_screen.dart';
import 'package:whisper/Features/Views/screens/status_screen2.dart';
import 'package:whisper/Models/statusModel.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
    case SelectContactScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectContactScreen());
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments["name"];
      final uid = arguments["uid"];
      return MaterialPageRoute(
          builder: (context) => MobileChatScreen(
                name: name,
                uid: uid,
              ));
    case ConfirmStatus.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
          builder: (context) => ConfirmStatus(
                file: file,
              ));
    case StatusScreen2.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
          builder: (context) => StatusScreen2(status: status));
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: "This Page Does Not Exist"),
        ),
      );
  }
}
