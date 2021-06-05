import 'dart:io';
import 'package:kbu_app/model/Story.dart';
import 'package:kbu_app/model/activity.dart';
import 'package:kbu_app/model/group.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/model/speech.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/services/notificationSendService.dart';
import 'package:kbu_app/services/auth_base.dart';
import 'package:kbu_app/services/firebase_auth_service.dart';
import 'package:kbu_app/services/firebase_storage_service.dart';
import 'package:kbu_app/services/firestore_db_service.dart';
import 'package:kbu_app/services/locator.dart';
import 'package:kbu_app/model/groupSpeech.dart';

enum AppMode { DEBUG, RELEASE }

class UserRepository implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FireStoreDbService _fireStoreDbService = locator<FireStoreDbService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  NotificationSendService _notificationSendService =
      locator<NotificationSendService>();

  AppMode appMode = AppMode.DEBUG;
  Map<String, String> userToken = Map<String, String>();

  @override
  Future<UserModel> currentUser() async {
    if (appMode == AppMode.DEBUG) {
      UserModel _user = await _firebaseAuthService.currentUser();
      return await _fireStoreDbService.readUser(_user.userID);
    } else {
      UserModel _user = await _firebaseAuthService.currentUser();
      if (_user != null) {
        return await _fireStoreDbService.readUser(_user.userID);
      } else {
        return null;
      }
    }
  }

  @override
  Future<UserModel> signInAnonymusly() async {
    if (appMode == AppMode.DEBUG) {
      return await _firebaseAuthService.signInAnonymusly();
    } else {
      return await _firebaseAuthService
          .signInAnonymusly(); //başka servis ekleyebiliriz
    }
  }

  @override
  Future<bool> signOut() async {
    if (appMode == AppMode.DEBUG) {
      return await _firebaseAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut(); //başka servis ekleyebiliriz
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      UserModel _user = await _firebaseAuthService
          .createUserWithEmailandPassword(email, password);
      bool _result = await _fireStoreDbService.saveUser(_user);
      if (_result) {
        return await _fireStoreDbService.readUser(_user.userID);
      } else
        return null;
    } else {
      //başka servis ekleyebiliriz
      UserModel _user = await _firebaseAuthService
          .createUserWithEmailandPassword(email, password);
      bool _result = await _fireStoreDbService.saveUser(_user);
      if (_result) {
        return await _fireStoreDbService.readUser(_user.userID);
      } else
        return null;
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    if (appMode == AppMode.DEBUG) {
      UserModel _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);
      return await _fireStoreDbService.readUser(_user.userID);
    } else {
      UserModel _user = await _firebaseAuthService.signInWithEmailandPassword(
          email, password);
      return await _fireStoreDbService
          .readUser(_user.userID); //başka servis ekleyebiliriz
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    if (appMode == AppMode.DEBUG) {
      UserModel _user = await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _fireStoreDbService.saveUser(_user);
      if (_sonuc) {
        return await _fireStoreDbService.readUser(_user.userID);
      } else {
        return null;
      }
    } else {
      UserModel _user = await _firebaseAuthService.signInWithGoogle();
      bool _sonuc = await _fireStoreDbService.saveUser(_user);
      if (_sonuc) {
        return await _fireStoreDbService.readUser(_user.userID);
      } else {
        return null;
      }
    }
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    if (appMode == AppMode.DEBUG) {
      return await _fireStoreDbService.updateUserName(userID, newUserName);
    } else {
      return await _fireStoreDbService.updateUserName(
          userID, newUserName); //başka servis ekleyebiliriz
    }
  }

  Future<String> uploadFile(
      String userID, String fileType, File profilePhoto) async {
    if (appMode == AppMode.DEBUG) {
      var url = await _firebaseStorageService.uploadFile(
          userID, fileType, profilePhoto);
      await _fireStoreDbService.updateProfilePhoto(url, userID);
      return url;
    } else {
      var url = await _firebaseStorageService.uploadFile(
          userID, fileType, profilePhoto);
      await _fireStoreDbService.updateProfilePhoto(url, userID);
      return url; //başka servis ekleyebiliriz
    }
  }

  Future<List<UserModel>> getAllUser() async {
    if (appMode == AppMode.DEBUG) {
      var allUserList = await _fireStoreDbService.getAllUser();
      return allUserList;
    } else {
      var allUserList = await _fireStoreDbService.getAllUser();
      return allUserList; //başka servis ekleyebiliriz
    }
  }

  Stream<List<Message>> getMessages(
      String currentUserID, String chattedUserID) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getMessages(currentUserID, chattedUserID);
    } else {
      return _fireStoreDbService.getMessages(currentUserID, chattedUserID);
    }
  }

  Stream<List<Message>> getGroupMessages(
      String currentUserID, String chattedUserID) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getGroupMessages(currentUserID, chattedUserID);
    } else {
      return _fireStoreDbService.getGroupMessages(currentUserID, chattedUserID);
    }
  }

  Future<bool> saveMessage(Message saveMessage, UserModel currentUser) async {
    if (appMode == AppMode.DEBUG) {
      var result = await _fireStoreDbService.saveMessage(saveMessage);
      if (result) {
        var token = "";
        if (userToken.containsKey(saveMessage.who)) {
          token = userToken[saveMessage.who];
        } else {
          token = await _fireStoreDbService.tokenGet(saveMessage.who);
          if (token != null) userToken[saveMessage.who] = token;
        }
        if (token != null)
          await _notificationSendService.sendNotification(
              saveMessage, currentUser, token);
        return true;
      } else {
        return false;
      }
    } else {
      var result = await _fireStoreDbService.saveMessage(saveMessage);
      if (result) {
        var token = "";
        if (userToken.containsKey(saveMessage.who)) {
          token = userToken[saveMessage.who];
        } else {
          token = await _fireStoreDbService.tokenGet(saveMessage.who);
          if (token != null) userToken[saveMessage.who] = token;
        }
        if (token != null)
          await _notificationSendService.sendNotification(
              saveMessage, currentUser, token);
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> saveGroupMessage(
      Message saveMessage, UserModel currentUser) async {
    if (appMode == AppMode.DEBUG) {
      var result = await _fireStoreDbService.saveGroupMessage(saveMessage);
      if (result) {
        var token = "";
        if (userToken.containsKey(saveMessage.who)) {
          token = userToken[saveMessage.who];
        } else {
          token = await _fireStoreDbService.tokenGet(saveMessage.who);
          if (token != null) userToken[saveMessage.who] = token;
        }
        if (token != null)
          await _notificationSendService.sendNotification(
              saveMessage, currentUser, token);
        return true;
      } else {
        return false;
      }
    } else {
      var result = await _fireStoreDbService.saveMessage(saveMessage);
      if (result) {
        var token = "";
        if (userToken.containsKey(saveMessage.who)) {
          token = userToken[saveMessage.who];
        } else {
          token = await _fireStoreDbService.tokenGet(saveMessage.who);
          if (token != null) userToken[saveMessage.who] = token;
        }
        if (token != null)
          await _notificationSendService.sendNotification(
              saveMessage, currentUser, token);
        return true;
      } else {
        return false;
      }
    }
  }

  Stream<List<Speech>> getAllConversation(String userID) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getAllConversations(userID);
    } else {
      return _fireStoreDbService.getAllConversations(userID);
    }
  }

  Stream<List<GroupSpeech>> getAllGroupConversation(String userID) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getAllGroupConversation(userID);
    } else {
      return _fireStoreDbService.getAllGroupConversation(userID);
    }
  }

  Future<List<Message>> getMessageWithPagination(String currentUserID,
      String chattedUserID, Message lastMessage, int total) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getMessageWithPagination(
          currentUserID, chattedUserID, lastMessage, total);
    } else {
      return _fireStoreDbService.getMessageWithPagination(
          currentUserID, chattedUserID, lastMessage, total);
    }
  }

  Future<List<Message>> getGroupMessageWithPagination(String currentUserID,
      String chattedUserID, Message lastMessage, int total) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getGroupMessageWithPagination(
          currentUserID, chattedUserID, lastMessage, total);
    } else {
      return _fireStoreDbService.getGroupMessageWithPagination(
          currentUserID, chattedUserID, lastMessage, total);
    }
  }

  Future<String> uploadStory(String userID, String fileType, File profilePhoto,
      String description) async {
    if (appMode == AppMode.DEBUG) {
      var url = await _firebaseStorageService.uploadStory(
          userID, fileType, profilePhoto, description);
      await _fireStoreDbService.addStatus(url, userID, description);
      return url;
    } else {
      var url = await _firebaseStorageService.uploadStory(
          userID, fileType, profilePhoto, description);
      await _fireStoreDbService.addStatus(url, userID, description);
      return url; //başka servis ekleyebiliriz
    }
  }

  Stream<List<Story>> getAllStory() {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.getAllStory();
    } else {
      return _fireStoreDbService.getAllStory();
    }
  }

  void deleteConversation(List<String> deletedConversation) {
    if (appMode == AppMode.DEBUG) {
      return _fireStoreDbService.deletedConversation(deletedConversation);
    } else {
      return _fireStoreDbService.deletedConversation(deletedConversation);
    }
  }

  Future<String> uploadNewsFile(
      String documentID, String fileType, File haberFoto) async {
    if (appMode == AppMode.DEBUG) {
      var newsFotoURL = await _firebaseStorageService.uploadNewsFile(
          documentID, fileType, haberFoto);
      return newsFotoURL;
    } else {
      var newsFotoURL = await _firebaseStorageService.uploadNewsFile(
          documentID, fileType, haberFoto);
      return newsFotoURL;
    }
  }

  Future<bool> createNews(News news) async {
    var sonuc = await _fireStoreDbService.createNews(news);
    print("CreatedNews:");
    return sonuc;
  }

  Future<List<News>> getAllNews() async {
    if (appMode == AppMode.DEBUG) {
      var tumHaberlerListesi = await _fireStoreDbService.getAllNews();
      return tumHaberlerListesi;
    } else {
      var tumHaberlerListesi = await _fireStoreDbService.getAllNews();
      return tumHaberlerListesi;
    }
  }

  Future<bool> createActivity(Activity activity) async {
    var sonuc = await _fireStoreDbService.createActivity(activity);
    print("CreatedNews:");
    return sonuc;
  }

  Future<List<Activity>> getAllActivity() async {
    if (appMode == AppMode.DEBUG) {
      var tumHaberlerListesi = await _fireStoreDbService.getAllActivity();
      return tumHaberlerListesi;
    } else {
      var tumHaberlerListesi = await _fireStoreDbService.getAllActivity();
      return tumHaberlerListesi;
    }
  }

  Future<String> uploadGroupFile(String documentID, String fileType,
      File haberFoto, String description) async {
    if (appMode == AppMode.DEBUG) {
      var groupImgUrl = await _firebaseStorageService.uploadGroupFile(
          documentID, fileType, haberFoto, description);
      return groupImgUrl;
    } else {
      var groupImgUrl = await _firebaseStorageService.uploadGroupFile(
          documentID, fileType, haberFoto, description);
      return groupImgUrl;
    }
  }

  Future<bool> createGroup(Group group) async {
    var result = await _fireStoreDbService.createGroup(group);
    return result;
  }

  Future<String> updateGroupPhoto(String documentID, String fileType,
      File haberFoto, String description) async {
    if (appMode == AppMode.DEBUG) {
      var groupImgUrl = await _firebaseStorageService.uploadGroupFile(
          documentID, fileType, haberFoto, description);
      await _fireStoreDbService.updateGroupProfilePhoto(groupImgUrl, documentID);
      return groupImgUrl;
    } else {
      var groupImgUrl = await _firebaseStorageService.uploadGroupFile(
          documentID, fileType, haberFoto, description);
      return groupImgUrl;
    }
  }

  Future<void> updateMembers(List<dynamic> members,String groupID) async{

    if (appMode == AppMode.DEBUG) {
      await _fireStoreDbService.updateMembers(members,groupID);
    } else {
      await _fireStoreDbService.updateMembers(members,groupID);
    }
  }
}
