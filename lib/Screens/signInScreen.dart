import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whisper/Screens/signUpScreen.dart';
import 'package:whisper/Utils/navigate.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var _formKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String msg = "";
  bool isLoding = false;
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
                  "Sign in",
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
                      return null;
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
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset("assets/icons/password.svg"),
                      ),
                    ),
                  ),
                ),
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
                    label: const Text("Sign In"),
                  ),
                ),
                Row(
                  children: const [
                    Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 90),
                  child: Text(
                    "Sign in with Google",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        "assets/icons/google_box.svg",
                        height: 64,
                        width: 64,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  child: Row(
                    children: [
                      const Text(
                        "Do Not Have An Account ?",
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigateToPage(context, const SignUpScreen());
                        },
                        child: const Text(
                          "SIGN UP",
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
