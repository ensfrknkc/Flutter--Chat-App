import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String fromWho;
  final String who;
  final bool fromMe;
  final String message;
  final Timestamp date;

  Message({this.fromWho, this.who, this.fromMe, this.message, this.date});

  Map<String,dynamic> toMap(){
    return {
      'fromWho' : fromWho,
      'who' : who,
      'fromMe' : fromMe,
      'message' :message,
      'date' : date??FieldValue.serverTimestamp(),
    };
  }

  Message.fromMap(Map<String,dynamic> map):
        fromWho = map['fromWho'],
        who = map['who'],
        fromMe = map['fromMe'],
        message = map['message'],
        date = map['date'];

  @override
  String toString() {
    return 'Message{fromWho: $fromWho, who: $who, fromMe: $fromMe, message: $message, date: $date}';
  }
}