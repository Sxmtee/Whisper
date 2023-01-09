import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Models/chatcontactModel.dart';
import 'package:whisper/Models/userModel.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({required this.firestore, required this.auth});

  void _saveDataToContactSubcollection(
      UserModel senderUserData,
      UserModel receiverUserData,
      String text,
      DateTime timeSent,
      String receiverUserId) async {
    var recieverChatContact = ChatContactModel(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required UserModel senderUser,
  }) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;

      var userDataMap =
          await firestore.collection("users").doc(receiverUserId).get();
      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      _saveDataToContactSubcollection(
          senderUser, receiverUserData, text, timeSent, receiverUserId);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
