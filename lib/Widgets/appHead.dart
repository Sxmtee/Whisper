import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Utils/colors.dart';

AppBar dashboardHead(context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Container(),
    titleSpacing: 0.0,
    title: Container(
        child: SvgPicture.asset(
      "assets/icons/whisper4a.svg",
      color: AppColors.primaryColor,
      height: 80,
    )),
    centerTitle: true,
    elevation: 0.1,
    actions: [
      IconButton(
          onPressed: (() async {
            await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => SignInScreen())),
                (route) => false);
          }),
          icon: Icon(
            Icons.logout,
            color: AppColors.primaryColor,
          ))
    ],
  );
}
