import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/homeScreen.dart';
import 'package:whisper/Screens/signInScreen.dart';
import 'package:whisper/Screens/splashScreen.dart';
import 'package:whisper/Utils/navigate.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseFirestore Firestore = FirebaseFirestore.instance;

Future GoogleInFunction() async {
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
}

Future SignUpFunction(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    var id = userCredential.user!.uid;
    var userDetails = {
      "email": userCredential.user!.email,
      "name": userCredential.user!.displayName,
      "image": userCredential.user!.photoURL,
      "uid": id,
      "date": DateTime.now()
    };
    Firestore.collection("users").doc(id).set(userDetails);
  } catch (e) {
    print(Text("Error: ${e.toString()}"));
  }
}

Future SignInFunction(
  String email,
  String password,
) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var id = userCredential.user!.uid;
    Firestore.collection("users").doc(id).get();
  } catch (e) {
    print(Text("Error: ${e.toString()}"));
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

void signInWithId(String uid, BuildContext context) async {
  try {
    DocumentSnapshot userData =
        await Firestore.collection("users").doc(uid).get();

    UserModel userModel = UserModel.fromJson(userData);

    NavigateToPage(context, HomeScreen(userModel));
  } catch (e) {
    print(uid);
    print(Text("Error: ${e.toString()}"));
    NavigateToPage(context, const SignInScreen());
  }
}
