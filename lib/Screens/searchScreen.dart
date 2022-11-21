import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Screens/chatScreen.dart';

class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user);
  // const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  bool isLoading = false;

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()["email"] != widget.user.email) {
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Whisper To Your Friends"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Type Whispername",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: (() {
                    onSearch();
                  }),
                  icon: Icon(Icons.search))
            ],
          ),
          if (searchResult.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        child: Image.network(searchResult[index]["image"])),
                    title: Text(searchResult[index]["name"]),
                    subtitle: Text(searchResult[index]["email"]),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          searchController.text = "";
                        });
                        var route = MaterialPageRoute(
                            builder: ((context) => ChatScreen(
                                currentUser: widget.user,
                                friendId: searchResult[index]["uid"],
                                friendName: searchResult[index]["name"],
                                friendImage: searchResult[index]["image"])));
                        Navigator.push(context, route);
                      },
                      icon: Icon(Icons.message),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
