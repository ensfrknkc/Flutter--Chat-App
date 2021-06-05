import 'package:cloud_firestore/cloud_firestore.dart';

class GroupSpeech {
  final String messageOwner;
  final String chatWith;
  final String lastMessage;
  final bool seen;
  final Timestamp createDate;
  final Timestamp seenDate;
  String groupName;
  String groupImgUrl;
  String administrator;
  String docId;
  String role;
  List<dynamic> members = [];
  String chattedUserName;
  String chattedUserProfileUrl;

  GroupSpeech(
      {this.messageOwner,
      this.chatWith,
      this.lastMessage,
      this.seen,
      this.createDate,
      this.groupName,
      this.groupImgUrl,
      this.administrator,
      this.docId,
      this.role,
      this.members,
      this.seenDate});

  Map<String, dynamic> toMap() {
    return {
      'messageOwner': messageOwner,
      'chatWith': chatWith,
      'lastMessage': lastMessage ?? FieldValue.serverTimestamp(),
      'seen': seen,
      'seenDate': seenDate,
      'createDate': createDate ?? FieldValue.serverTimestamp(),
      'groupName': groupName,
      'groupImgUrl': groupImgUrl ??
          'https://img.favpng.com/25/7/19/users-group-computer-icons-png-favpng-WKWD9rqs5kwcviNe9am7xgiPx.jpg',
      'administrator': administrator,
      'docId': docId,
      'role': role,
      'members': members,
    };
  }

  GroupSpeech.fromMap(Map<String, dynamic> map)
      : messageOwner = map['messageOwner'],
        chatWith = map['chatWith'],
        lastMessage = map['lastMessage'],
        seen = map['seen'],
        seenDate = map['seenDate'],
        groupName = map['groupName'],
        groupImgUrl = map['groupImgUrl'],
        administrator = map['administrator'],
        docId = map['docId'],
        role = map['role'],
        members = map['members'],
        createDate = map['createDate'];

  @override
  String toString() {
    return 'Speech{messageOwner: $messageOwner, chatWith: $chatWith, lastMessage: $lastMessage, seen: $seen,groupName: $groupName, groupImgUrl: $groupImgUrl, administrator: $administrator,docId: $docId,role:$role, members: $members, createDate: $createDate, seenDate: $seenDate}';
  }
}
