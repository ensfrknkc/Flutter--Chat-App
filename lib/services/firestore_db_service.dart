import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kbu_app/model/Story.dart';
import 'package:kbu_app/model/activity.dart';
import 'package:kbu_app/model/group.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/model/speech.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/services/database_base.dart';
import 'package:kbu_app/model/groupSpeech.dart';

class FireStoreDbService implements DbBase {
  @override
  Future<bool> saveUser(UserModel user) async {
    if (user.email.contains("gmail")) {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection("users").doc(user.userID).set(user.toMap());
    } else {
      user.role = "Student";
      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      await _firestore.collection("users").doc(user.userID).set(user.toMap());
    }

    return true;
  }

  @override
  Future<UserModel> readUser(String userId) async {
    DocumentSnapshot readUser =
        await FirebaseFirestore.instance.collection("users").doc(userId).get();
    UserModel readeduser = UserModel.fromMap(readUser.data());
    print(readeduser.toString());
    return readeduser;
  }

  @override
  Future<bool> updateUserName(String userId, String newUserName) async {
    var users = await FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: newUserName)
        .get();
    if (users.docs.length > 0) {
      return false;
    } else {
      await Future.value(FirebaseFirestore.instance.collection("users")
        ..doc(userId).update({'userName': newUserName}));
      return true;
    }
  }

  @override
  Future<bool> updateProfilePhoto(String url, String userId) async {
    await Future.value(FirebaseFirestore.instance.collection("users")
      ..doc(userId).update({'profileURL': url}));
    return true;
  }
  @override
  Future<bool> updateGroupProfilePhoto(String url, String groupID) async {
    await Future.value(FirebaseFirestore.instance.collection("groups")
      ..doc(groupID).update({'groupImgUrl': url}));
    return true;
  }

  @override
  Future<List<UserModel>> getAllUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .orderBy("userName")
        .get();

    List<UserModel> allUser = [];
    for (DocumentSnapshot oneUser in querySnapshot.docs) {
      UserModel _oneUser = UserModel.fromMap(oneUser.data());
      allUser.add(_oneUser);
      print(_oneUser);
    }
    return allUser;
  }

  @override
  Stream<List<Speech>> getAllConversations(String userID) {
    var snapShot = FirebaseFirestore.instance
        .collection("speeches")
        .where("messageOwner", isEqualTo: userID)
        .orderBy("createDate", descending: true)
        .snapshots();
    return snapShot.map((conversationList) => conversationList.docs
        .map((conversation) => Speech.fromMap(conversation.data()))
        .toList());
  }

  @override
  Stream<List<GroupSpeech>> getAllGroupConversation(String userID) {
    var snapShot = FirebaseFirestore.instance
        .collection("groups")
        .where("members", arrayContains: userID)
        .orderBy("createDate", descending: true)
        .snapshots();
    return snapShot.map((conversationList) => conversationList.docs
        .map((conversation) => GroupSpeech.fromMap(conversation.data()))
        .toList());
  }

  @override
  Stream<List<Message>> getMessages(
      String currentUserID, String chattedUserID) {
    var snapShot = FirebaseFirestore.instance
        .collection("speeches")
        .doc(currentUserID + "--" + chattedUserID)
        .collection("messages")
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((messageList) => messageList.docs
        .map((message) => Message.fromMap(message.data()))
        .toList());
  }

  @override
  Stream<List<Message>> getGroupMessages(
      String currentUserID, String chattedUserID) {
    var snapShot = FirebaseFirestore.instance
        .collection("groups")
        .doc(chattedUserID)
        .collection("messages")
        .orderBy("date", descending: true)
        .limit(1)
        .snapshots();
    return snapShot.map((messageList) => messageList.docs
        .map((message) => Message.fromMap(message.data()))
        .toList());
  }

  @override
  Future<bool> saveMessage(Message saveMessage) async {
    var _messageID = FirebaseFirestore.instance.collection("speeches").doc().id;
    var _myDocID = saveMessage.fromWho + "--" + saveMessage.who;
    var _receiverDocID = saveMessage.who + "--" + saveMessage.fromWho;
    var _saveMessageToMap = saveMessage.toMap();
    await FirebaseFirestore.instance
        .collection("speeches")
        .doc(_myDocID)
        .collection("messages")
        .doc(_messageID)
        .set(_saveMessageToMap);
    await FirebaseFirestore.instance.collection("speeches").doc(_myDocID).set({
      "messageOwner": saveMessage.fromWho,
      "chatWith": saveMessage.who,
      "lastMessage": saveMessage.message,
      "seen": false,
      "createDate": FieldValue.serverTimestamp(),
    });

    _saveMessageToMap.update("fromMe", (value) => false);
    await FirebaseFirestore.instance
        .collection("speeches")
        .doc(_receiverDocID)
        .collection("messages")
        .doc(_messageID)
        .set(_saveMessageToMap);
    await FirebaseFirestore.instance
        .collection("speeches")
        .doc(_receiverDocID)
        .set({
      "messageOwner": saveMessage.who,
      "chatWith": saveMessage.fromWho,
      "lastMessage": saveMessage.message,
      "seen": false,
      "createDate": FieldValue.serverTimestamp(),
    });

    return true;
  }

  @override
  Future<bool> saveGroupMessage(Message saveMessage) async {
    var _messageID = FirebaseFirestore.instance.collection("groups").doc().id;
    var _myDocID = saveMessage.who;
    var _saveMessageToMap = saveMessage.toMap();
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(_myDocID)
        .collection("messages")
        .doc(_messageID)
        .set(_saveMessageToMap);
    await FirebaseFirestore.instance.collection("groups").doc(_myDocID).update({
      "messageOwner": saveMessage.fromWho,
      "chatWith": saveMessage.who,
      "lastMessage": saveMessage.message,
      "seen": false,
      "createDate": FieldValue.serverTimestamp(),
    });
    return true;
  }

  Future<List<Message>> getMessageWithPagination(String currentUserID,
      String chattedUserID, Message lastMessage, int total) async {
    QuerySnapshot _querySnapshot;
    List<Message> _allMessage = [];
    if (lastMessage == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("speeches")
          .doc(currentUserID + "--" + chattedUserID)
          .collection("messages")
          .orderBy("date", descending: true)
          .limit(total)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("speeches")
          .doc(currentUserID + "--" + chattedUserID)
          .collection("messages")
          .orderBy("date", descending: true)
          .startAfter([lastMessage.date])
          .limit(total)
          .get();
      await Future.delayed(Duration(seconds: 1));
    }
    for (DocumentSnapshot snap in _querySnapshot.docs) {
      Message _oneMessage = Message.fromMap(snap.data());
      _allMessage.add(_oneMessage);
    }
    return _allMessage;
  }

  Future<List<Message>> getGroupMessageWithPagination(String currentUserID,
      String chattedUserID, Message lastMessage, int total) async {
    QuerySnapshot _querySnapshot;
    List<Message> _allMessage = [];
    if (lastMessage == null) {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("groups")
          .doc(chattedUserID)
          .collection("messages")
          .orderBy("date", descending: true)
          .limit(total)
          .get();
    } else {
      _querySnapshot = await FirebaseFirestore.instance
          .collection("groups")
          .doc(chattedUserID)
          .collection("messages")
          .orderBy("date", descending: true)
          .startAfter([lastMessage.date])
          .limit(total)
          .get();
      await Future.delayed(Duration(seconds: 1));
    }
    for (DocumentSnapshot snap in _querySnapshot.docs) {
      Message _oneMessage = Message.fromMap(snap.data());
      _allMessage.add(_oneMessage);
    }
    return _allMessage;
  }

  Future<String> tokenGet(String who) async {
    DocumentSnapshot _token =
        await FirebaseFirestore.instance.doc("tokens/" + who).get();
    if (_token != null)
      return _token.data()["token"];
    else
      return null;
  }

  @override
  Future<bool> addStatus(String url, String userId, String description) async {
    Story saveStoryToMap =
        Story(description: description, storyUrl: url, userId: userId);
    await FirebaseFirestore.instance
        .collection("stories")
        .doc(description)
        .set(saveStoryToMap.toMap());
    return true;
  }

  Stream<List<Story>> getAllStory() {
    var snapShot = FirebaseFirestore.instance
        .collection("stories")
        .orderBy("date", descending: true)
        .snapshots();
    return snapShot.map((conversationList) => conversationList.docs
        .map((conversation) => Story.fromMap(conversation.data()))
        .toList());
  }

  void deletedConversation(List<String> deletedConversation) {
    var deleted = FirebaseFirestore.instance.collection("speeches");

    for (var i in deletedConversation) {
      deleted.doc(i).collection("messages").get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });
      deleted.doc(i).delete();

      print("silindi");
    }
  }

  @override
  Future<List<News>> getAllNews() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("news")
        .orderBy("createdAt", descending: true)
        .get();
    List<News> tumHaberler = [];
    for (DocumentSnapshot tekHaber in querySnapshot.docs) {
      News _tekHaber = News.fromMap(tekHaber.data());
      tumHaberler.add(_tekHaber);
    }
    return tumHaberler;
  }

  @override
  Future<bool> createNews(News news) async {
    var _kaydedilecekNewsMapYapisi = news.toMap();
    var _myDocumentID = news.documentName;
    await FirebaseFirestore.instance
        .collection("news")
        .doc(_myDocumentID)
        .set(_kaydedilecekNewsMapYapisi);
    return true;
  }

  Future<bool> createActivity(Activity activity) async {
    var _kaydedilecekNewsMapYapisi = activity.toMap();
    await FirebaseFirestore.instance
        .collection("activity")
        .doc(activity.title + activity.date)
        .set(_kaydedilecekNewsMapYapisi);
    return true;
  }

  Future<List<Activity>> getAllActivity() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("activity")
        .orderBy("createdAt", descending: true)
        .get();
    List<Activity> tumHaberler = [];
    for (DocumentSnapshot tekHaber in querySnapshot.docs) {
      Activity _tekHaber = Activity.fromMap(tekHaber.data());
      tumHaberler.add(_tekHaber);
    }
    return tumHaberler;
  }

  @override
  Future<bool> createGroup(Group group) async {
    var saveGroupToMap = group.toMap();
    var _myDocumentID = group.docId;
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(_myDocumentID)
        .set(saveGroupToMap);

    return true;
  }

  @override
  Future<void> updateMembers(List<dynamic> members,String groupID) async{
    await Future.value(FirebaseFirestore.instance.collection("groups")
      ..doc(groupID).update({'members': members}));
  }
}
