import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  // static late UserModel _shared;
  String email;
  String name;
  String image;
  Timestamp date;
  String uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.image,
      required this.date,
      required this.uid}) {
    // _shared = this;
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        email: snapshot["email"],
        name: snapshot["name"],
        image: snapshot["image"],
        date: snapshot["date"],
        uid: snapshot["uid"]);
  }

  // factory UserModel.instance() => _shared;
}
