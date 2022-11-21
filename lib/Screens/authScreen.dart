import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/Screens/homeScreen.dart';
import 'package:whisper/main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GoogleSignIn googleSignIn = GoogleSignIn();

  FirebaseFirestore Firestore = FirebaseFirestore.instance;

  Future SignInFunction() async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist =
        await Firestore.collection("users").doc(userCredential.user!.uid).get();
    if (userExist.exists) {
      print("User Exists");
    } else {
      await Firestore.collection("users").doc(userCredential.user!.uid).set({
        "email": userCredential.user!.email,
        "name": userCredential.user!.displayName,
        "image": userCredential.user!.photoURL,
        "uid": userCredential.user!.uid,
        "date": DateTime.now()
      });
    }

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Images/chatzo.png"))),
              ),
            ),
            Text(
              "Whisper",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: (() async {
                await SignInFunction();
              }),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset("assets/Images/googlelogo.png")),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 12))),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
