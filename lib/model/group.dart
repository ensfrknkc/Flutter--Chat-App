import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Group{
  String groupName;
  String groupImgUrl;
  String administrator;
  String docId;
  String role;
  List<dynamic> members = [];
  DateTime createdAt;
  DateTime updatedAt;

  Group({
    this.groupName,
    this.groupImgUrl,
    this.administrator,
    this.docId,
    this.role,
    this.members,
    this.createdAt,
    this.updatedAt
  });

  Map<String, dynamic> toMap() {
    return {
      'groupName': groupName,
      'groupImgUrl': groupImgUrl ?? 'https://img.favpng.com/25/7/19/users-group-computer-icons-png-favpng-WKWD9rqs5kwcviNe9am7xgiPx.jpg',
      'administrator': administrator,
      'docId':docId,
      'role':role,
      'members': members,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  Group.fromMap(Map<String, dynamic> map)
      : groupName = map['groupName'],
        groupImgUrl = map['groupImgUrl'],
        administrator = map['administrator'],
        docId = map['docId'],
        role = map['role'],
        members = map['members'],
        createdAt = map['createdAt'],
        updatedAt = map['updatedAt'];

  @override
  String toString() {
    return 'Group{groupName: $groupName, groupImgUrl: $groupImgUrl, administrator: $administrator,docId: $docId,role:$role, members: $members, createdAt: $createdAt, updatedAt: $updatedAt,}';
  }


}