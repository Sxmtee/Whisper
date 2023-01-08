import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                onPressed: () {},
                text: "NEXT",
              ),
            )
          ],
        ),
      ),
    );
  }
}
