import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Features/Views/screens/chatScreen.dart';
import 'package:whisper/Features/Views/screens/searchScreen.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Common/Widgets/appHead.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;
  HomeScreen(this.user);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int count = 0;
  goBack() {
    if (count >= 1) {
      SystemNavigator.pop();
    } else {
      count++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack();
        showSnackBar(context, "Double Tap To Exit");
        return await false;
      },
      child: Scaffold(
        appBar: dashboardHead(context),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(widget.user.uid)
              .collection("messages")
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return const Center(
                  child: Text("No Available Whispmates"),
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
                          subtitle: Text(
                            "$lastMsg",
                            style: const TextStyle(color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            var route = MaterialPageRoute(
                builder: ((context) => SearchScreen(widget.user)));
            Navigator.push(context, route);
          },
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
