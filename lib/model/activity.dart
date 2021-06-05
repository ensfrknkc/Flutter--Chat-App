
import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String title;
  String content;
  String date;
  DateTime createdAt;

  Activity({
    this.title,
    this.content,
    this.date,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date':date,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  Activity.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        content = map['content'],
        date = map['date'],
        createdAt = (map['createdAt'] as Timestamp).toDate();

  @override
  String toString() {
    return 'News{title: $title,content:$content,date:$date,createdAt:$createdAt}';
  }
}