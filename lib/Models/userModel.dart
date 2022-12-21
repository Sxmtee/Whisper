import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;
  String image;
  Timestamp date;
  String uid;
  String? about;

  UserModel(
      {required this.email,
      required this.name,
      required this.image,
      required this.date,
      required this.uid,
      this.about});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
        email: snapshot["email"],
        name: snapshot["name"],
        image: snapshot["image"],
        date: snapshot["date"],
        uid: snapshot["uid"]);
  }
}
