import 'package:cloud_firestore/cloud_firestore.dart';

class Speech {
  final String messageOwner;
  final String chatWith;
  final String lastMessage;
  final bool seen;
  final Timestamp createDate;
  final Timestamp seenDate;
  String chattedUserName;
  String chattedUserProfileUrl;

  Speech(
      {this.messageOwner,
      this.chatWith,
      this.lastMessage,
      this.seen,
      this.createDate,
      this.seenDate});

  Map<String, dynamic> toMap() {
    return {
      'messageOwner': messageOwner,
      'chatWith': chatWith,
      'lastMessage': lastMessage??FieldValue.serverTimestamp(),
      'seen': seen,
      'seenDate': seenDate,
      'createDate': createDate ??FieldValue.serverTimestamp(),
    };
  }

  Speech.fromMap(Map<String, dynamic> map)
      : messageOwner = map['messageOwner'],
        chatWith = map['chatWith'],
        lastMessage = map['lastMessage'],
        seen = map['seen'],
        seenDate = map['seenDate'],
        createDate = map['createDate'];

  @override
  String toString() {
    return 'Speech{messageOwner: $messageOwner, chatWith: $chatWith, lastMessage: $lastMessage, seen: $seen, createDate: $createDate, seenDate: $seenDate}';
  }


}
