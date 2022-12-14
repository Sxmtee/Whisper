import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whisper/Controllers/authController.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/homeScreen.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Utils/navigate.dart';
import 'package:whisper/Utils/snackBar.dart';
import 'package:path/path.dart' as path;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();

  bool isLoading = false;

  XFile? image;

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<String> uploadImage() async {
    String fileName = path.basename(image!.path);
    Reference reference =
        FirebaseStorage.instance.ref().child("profileImage/" + fileName);
    UploadTask uploadTask = reference.putFile(File(image!.path));
    TaskSnapshot snapshot = await uploadTask;
    var imageUrl = await snapshot.ref.getDownloadURL();
    print(imageUrl);
    return imageUrl;
  }

  void register() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (image != null) {
        var imageUrl = await uploadImage();

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var id = userCredential.user!.uid;
        var userDetails = {
          "email": emailController.text,
          "name": nameController.text,
          "image": imageUrl,
          "uid": id,
          "date": DateTime.now()
        };
        firestore.collection("users").doc(id).set(userDetails);
        UserModel userModel = UserModel(
            email: emailController.text,
            name: nameController.text,
            image: imageUrl,
            date: DateTime.now() as Timestamp,
            uid: id);
        NavigateToPage(context, HomeScreen(userModel));
        setState(() {
          isLoading = false;
        });
      } else {}
    } catch (e) {
      print(Text("Error: ${e.toString()}"));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.only(top: 100, left: 25, right: 25),
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
                Stack(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: size.height / 40),
                        alignment: Alignment.topCenter,
                        child: image != null
                            ? CircleAvatar(
                                backgroundColor: Colors.white70,
                                radius: 100,
                                backgroundImage: FileImage(File(image!.path)))
                            : const CircleAvatar(
                                backgroundColor: Colors.white70,
                                radius: 100,
                                child: Icon(
                                  Icons.person,
                                  size: 150,
                                  color: Color(0xFFF77D8E),
                                ),
                              )),
                    Positioned(
                        top: 150,
                        right: 30,
                        child: MaterialButton(
                          onPressed: () {
                            pickImage();
                          },
                          color: Colors.white70,
                          padding: const EdgeInsets.all(20),
                          shape: const CircleBorder(),
                          child: const Icon(Icons.add_a_photo_rounded),
                        ))
                  ],
                ),
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
                  "Name",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Field";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SvgPicture.asset(
                          "assets/icons/User.svg",
                          color: const Color(0xFFF77D8E),
                        ),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        register();
                      }
                    },
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
