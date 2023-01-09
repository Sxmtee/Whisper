import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisper/Models/userModel.dart';
import 'package:whisper/Features/Views/screens/chatScreen.dart';
import 'package:whisper/Common/Utils/colors.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Common/Widgets/appHead.dart';

class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user);

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
        showSnackBar(context, "No User Found");
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()["name"] != widget.user.name) {
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
      appBar: dashboardHead(context),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "Search Whispname",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: (() {
                    onSearch();
                  }),
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ))
            ],
          ),
          Visibility(
            visible: isLoading,
            child: const CupertinoActivityIndicator(
              radius: 50,
              color: AppColors.primaryColor,
            ),
          ),
          if (searchResult.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
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
                    child: Card(
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                            child: Image.network(searchResult[index]["image"])),
                        title: Text(searchResult[index]["name"]),
                        subtitle: Text(searchResult[index]["email"]),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_rounded),
                        ),
                      ),
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
