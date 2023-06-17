import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Features/Auth/repositories/common_firebase_storage_repo.dart';
import 'package:whisper/Models/groupModel.dart' as model;

final groupRepositoryProvider = Provider(
  (ref) => GroupRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    ref: ref,
  ),
);

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;

  GroupRepository({
    required this.auth,
    required this.firestore,
    required this.ref,
  });

  void createGroup(
    BuildContext context,
    String name,
    File profilePic,
    List<Contact> selectedContact,
  ) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var userCollection = await firestore
            .collection("users")
            .where(
              "phoneNumber",
              isEqualTo:
                  selectedContact[i].phones[0].number.replaceAll(" ", ""),
            )
            .where(
              "createdAt",
              isGreaterThan: DateTime.now()
                  .subtract(const Duration(hours: 24))
                  .millisecondsSinceEpoch,
            )
            .get();
        if (userCollection.docs.isNotEmpty && userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()["uid"]);
        }
      }
      var groupId = const Uuid().v1();

      String profileUrl = await ref
          .read(commonFirebaseStorageRepoProvider)
          .storeFileToFirebase("group/$groupId", profilePic);

      model.GroupModel group = model.GroupModel(
        name: name,
        senderId: auth.currentUser!.uid,
        groupPic: profileUrl,
        lastMessage: "",
        membersUid: [auth.currentUser!.uid, ...uids],
        groupId: groupId,
        timeSent: DateTime.now(),
      );

      await firestore.collection("groups").doc(groupId).set(group.toMap());
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
