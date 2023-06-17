import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Features/Call/screen/call_screen.dart';
import 'package:whisper/Models/callModel.dart';
import 'package:whisper/Models/groupModel.dart' as model;

final callRepositoryProvider = Provider(
  (ref) => CallRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class CallRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CallRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<DocumentSnapshot> get callStream =>
      firestore.collection("call").doc(auth.currentUser!.uid).snapshots();

  void makeCall(
    CallModel senderCallData,
    BuildContext context,
    CallModel receiverCallData,
  ) async {
    try {
      await firestore
          .collection("call")
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());
      await firestore
          .collection("call")
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());

      var route = MaterialPageRoute(
        builder: (context) => CallScreen(
          channelId: senderCallData.callId,
          call: senderCallData,
          isGroupChat: false,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(context, route);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void makeGroupCall(
    CallModel senderCallData,
    BuildContext context,
    CallModel receiverCallData,
  ) async {
    try {
      await firestore
          .collection("call")
          .doc(senderCallData.callerId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firestore
          .collection("groups")
          .doc(senderCallData.receiverId)
          .get();
      model.GroupModel groupModel = model.GroupModel.fromMap(
        groupSnapshot.data()!,
      );
      for (var id in groupModel.membersUid) {
        await firestore
            .collection("call")
            .doc(id)
            .set(receiverCallData.toMap());
      }

      var route = MaterialPageRoute(
        builder: (context) => CallScreen(
          channelId: senderCallData.callId,
          call: senderCallData,
          isGroupChat: true,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(context, route);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void endCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      await firestore.collection("call").doc(callerId).delete();
      await firestore.collection("call").doc(receiverId).delete();
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void endGroupCall(
    String callerId,
    String receiverId,
    BuildContext context,
  ) async {
    try {
      await firestore.collection("call").doc(callerId).delete();
      var groupSnapshot =
          await firestore.collection("groups").doc(receiverId).get();
      model.GroupModel groupModel = model.GroupModel.fromMap(
        groupSnapshot.data()!,
      );
      for (var id in groupModel.membersUid) {
        await firestore.collection("call").doc(id).delete();
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
