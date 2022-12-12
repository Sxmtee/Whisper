import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Utils/navigate.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var _formKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String msg = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.only(top: 150, left: 25, right: 25),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      var emailValid = EmailValidator.validate(value!);
                      if (!emailValid) {
                        return "Invalid Email Address";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/email.svg"),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password too short";
                      }
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: isLoading,
                    child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: const LinearProgressIndicator(
                          color: Color(0xFFF77D8E),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF77D8E),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Color(0xFFFE0037),
                    ),
                    label: const Text("Sign Up"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Row(
                    children: [
                      const Text(
                        "Already Have An Account ?",
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigateToPage(context, const SignInScreen());
                        },
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
