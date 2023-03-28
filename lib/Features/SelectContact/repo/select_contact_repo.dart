import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Features/Chat/screen/mobile_chat_screen.dart';
import 'package:whisper/Models/userModel.dart';

final selectContactRepoProvider =
    Provider((ref) => SelectContactRepo(firestore: FirebaseFirestore.instance));

class SelectContactRepo {
  final FirebaseFirestore firestore;

  SelectContactRepo({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectedContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection("users").get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        String selectedPhoneNum =
            selectedContact.phones[0].number.replaceAll(" ", "");

        if (selectedPhoneNum == userData.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MobileChatScreen.routeName,
              arguments: {"name": userData.name, "uid": userData.uid});
        }
      }

      if (!isFound) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, "This Contact isn't a Whispmate");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
