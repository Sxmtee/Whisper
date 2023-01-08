import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Common/Widgets/custom_button.dart';
import 'package:whisper/Features/Auth/controllers/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? selectedCountry;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country country) {
          setState(() {
            selectedCountry = country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (selectedCountry != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInwithPhone(
          context, "+${selectedCountry!.phoneCode}$phoneNumber");
    } else {
      showSnackBar(context, "Select Your Country Code");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Phone Number"),
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text("Whisper will need to verify your phone number"),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: (() {
                  pickCountry();
                }),
                child: const Text("Pick Your Country")),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                if (selectedCountry != null)
                  Text("+${selectedCountry!.phoneCode}"),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: "Phone Number"),
                  ),
                )
              ],
            ),
            SizedBox(
              height: size.height / 18,
            ),
            SizedBox(
              width: 90,
              child: CustomButton(
                onPressed: sendPhoneNumber,
                text: "NEXT",
              ),
            )
          ],
        ),
      ),
    );
  }
}
