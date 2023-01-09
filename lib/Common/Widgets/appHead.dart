import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/Common/Utils/colors.dart';

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
            // await GoogleSignIn().signOut();
            await FirebaseAuth.instance.signOut();
          }),
          icon: Icon(
            Icons.logout,
            color: AppColors.primaryColor,
          ))
    ],
  );
}
