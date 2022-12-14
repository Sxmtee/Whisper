import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/Controllers/authController.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/homeScreen.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Utils/navigate.dart';
import 'package:whisper/Widgets/opacityBg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void signInWithId(String uid, BuildContext context) async {
    try {
      DocumentSnapshot userData =
          await firestore.collection("users").doc(uid).get();

      UserModel userModel = UserModel.fromJson(userData);

      NavigateToPage(context, HomeScreen(userModel));
    } catch (e) {
      print(Text("Error: ${e.toString()}"));
      NavigateToPage(context, const SignInScreen());
    }
  }

  void signInOldUser(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      signInWithId(user.uid, context);
    } else {
      NavigateToPage(context, const SignInScreen());
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      signInOldUser(context);
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
