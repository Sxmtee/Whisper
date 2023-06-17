import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whisper/Common/Utils/snackBar.dart';
import 'package:whisper/Models/callModel.dart';

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

  void makeCall(
    CallModel sendercallData,
    BuildContext context,
    CallModel receiverCallData,
  ) async {
    try {} catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
