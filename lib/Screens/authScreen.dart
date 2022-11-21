import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
              onPressed: (() {}),
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
