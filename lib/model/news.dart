import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String title;
  String content;
  String documentName;
  String imgURL;
  DateTime createdAt;

  News({
    this.title,
    this.content,
    this.documentName,
    this.imgURL,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'documentName': title,
      'imgURL': imgURL ?? 'https://www.karabuk.edu.tr/wp-content/themes/kbu/assets/images/logo.png',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  News.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        content = map['content'],
        documentName = map['documentName'],
        imgURL = map['imgURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate();

  @override
  String toString() {
    return 'News{title: $title,content:$content,documentName:$documentName,imgURL:$imgURL,createdAt:$createdAt}';
  }
}