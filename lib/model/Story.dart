import 'package:cloud_firestore/cloud_firestore.dart';

class Story{
  final String storyUrl;
  final String userId;
  final String description;
  final Timestamp date;

  Story({this.storyUrl,this.userId,this.description, this.date});

  Map<String,dynamic> toMap(){
    return {
      'storyUrl' : storyUrl,
      'userId' : userId,
      'description' : description,
      'date' : date??FieldValue.serverTimestamp(),
    };
  }

  Story.fromMap(Map<String,dynamic> map):
        storyUrl = map['storyUrl'],
        userId = map['userId'],
        description = map['description'],
        date = map['date'];


}