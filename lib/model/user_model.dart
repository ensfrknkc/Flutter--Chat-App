import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel {
  final String userID;
  String email;
  String userName;
  String profileURL;
  DateTime createdAt;
  DateTime updatedAt;
  String role;

  UserModel({@required this.userID, @required this.email});

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profileURL = map['profileURL'] ??
            "https://www.jing.fm/clipimg/detail/195-1952632_account-customer-login-man-user-icon-login-icon.png",
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        updatedAt = (map['updatedAt'] as Timestamp).toDate(),
        role = map['role'];

  UserModel.idAndImage({
    @required this.userID,
    @required this.profileURL,
    @required this.userName,
    @required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName': userName ?? email.substring(0, email.indexOf('@')),
      'profileURL': profileURL ?? '',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
      'role': role ?? "Other",
    };
  }

  @override
  String toString() {
    return 'UserModel{userID: $userID, email: $email, userName: $userName, profileURL: $profileURL, createdAt: $createdAt, updatedAt: $updatedAt, role: $role}';
  }
}
