import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Widgets/generalWidgets/custom_button.dart';
import 'package:whisper/Features/Auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Welcome to Whisper",
              style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.height / 9,
            ),
            SvgPicture.asset(
              "assets/icons/whisper4a.svg",
              color: AppColors.primaryColor,
              height: 340,
              width: 340,
            ),
            SizedBox(
              height: size.height / 18,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Read our Privacy Policy. Tap 'Agree and Continue' to accept the Terms of Service",
                style: TextStyle(
                  color: AppColors.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                text: "AGREE AND CONTINUE",
                onPressed: () {
                  navigateToLoginScreen(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
