import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/chatScreen.dart';
import 'package:whisper/Screens/searchScreen.dart';
import 'package:whisper/Screens/signInScreen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);
  // HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Whisper"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: (() async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => SignInScreen())),
                    (route) => false);
              }),
              icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.user.uid)
            .collection("messages")
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.length < 1) {
              return Center(
                child: Text("No Available Chats"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]["last_msg"];
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(friendId)
                      .get(),
                  builder: (context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      var friend = asyncSnapshot.data;
                      return ListTile(
                        onTap: () {
                          var route = MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                  currentUser: widget.user,
                                  friendId: friend["uid"],
                                  friendName: friend["name"],
                                  friendImage: friend["image"]));
                          Navigator.push(context, route);
                        },
                        leading: CircleAvatar(
                          child: Image.network(friend["image"]),
                        ),
                        title: Text(friend["name"]),
                        subtitle: Container(
                          child: Text(
                            "$lastMsg",
                            style: TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }
                    return LinearProgressIndicator();
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var route = MaterialPageRoute(
              builder: ((context) => SearchScreen(widget.user)));
          Navigator.push(context, route);
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
