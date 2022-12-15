import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:whisper/Screens/splashScreen.dart';
import 'package:whisper/Utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Future<Widget> userSignedIn() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     DocumentSnapshot userData = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user.uid)
  //         .get();
  //     UserModel userModel = UserModel.fromJson(userData);
  //     return HomeScreen(userModel);
  //   } else {
  //     return const SignInScreen();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whisper',
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: Color(0xFFEEF1F8),
          primarySwatch: Colors.blue,
          fontFamily: "Intel",
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          ),
        ),
        home: SplashScreen()
        // FutureBuilder(
        //   future: userSignedIn(),
        //   builder: (context, AsyncSnapshot<Widget> snapshot) {
        //     if (snapshot.hasData) {
        //       return snapshot.data!;
        //     }
        //     return const Scaffold(
        //       body: Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //     );
        //   },
        // ),
        );
  }
}

const defaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(16)),
  borderSide: BorderSide(
    color: Color(0xFFDEE3F2),
    width: 1,
  ),
);
