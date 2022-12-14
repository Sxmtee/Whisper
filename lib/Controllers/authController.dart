import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/homeScreen.dart';
import 'package:whisper/Utils/navigate.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

// Future signUpFunction(
//     String email, String password, BuildContext context) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password);
//     var id = userCredential.user!.uid;
//     var userDetails = {
//       "email": userCredential.user!.email,
//       "name": userCredential.user!.displayName,
//       "image": userCredential.user!.photoURL,
//       "uid": id,
//       "date": DateTime.now()
//     };
//     firestore.collection("users").doc(id).set(userDetails);
//     // UserModel userModel = UserModel(
//     //   email: userDetails['email'] as String,
//     //   name: userDetails['name'] as String,
//     //   image: userDetails['image'] as String,
//     //   uid: id,
//     //   date: userDetails['date'] as Timestamp,
//     // );
//     // NavigateToPage(context, HomeScreen(userModel));
//   } catch (e) {
//     print(Text("Error: ${e.toString()}"));
//   }
// }

Future signInFunction(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var id = userCredential.user!.uid;
    DocumentSnapshot doc = await firestore.collection("users").doc(id).get();
    UserModel userModel = UserModel.fromJson(doc);
    NavigateToPage(context, HomeScreen(userModel));
  } catch (e) {
    print(Text("Error: ${e.toString()}"));
  }
}

// void signInOldUser(BuildContext context) async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     signInWithId(user.uid, context);
//   } else {
//     NavigateToPage(context, const SignInScreen());
//   }
// }

// void signInWithId(String uid, BuildContext context) async {
//   try {
//     DocumentSnapshot userData =
//         await firestore.collection("users").doc(uid).get();

//     UserModel userModel = UserModel.fromJson(userData);

//     NavigateToPage(context, HomeScreen(userModel));
//   } catch (e) {
//     // print(uid);
//     print(Text("Error: ${e.toString()}"));
//     NavigateToPage(context, const SignInScreen());
//   }
// }
