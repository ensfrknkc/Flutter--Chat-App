import 'package:kbu_app/model/group.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/model/speech.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/model/groupSpeech.dart';

abstract class DbBase{

  Future<bool> saveUser(UserModel user);
  Future<UserModel> readUser(String userId);
  Future<bool> updateUserName(String userId,String newUserName);
  Future<bool> updateProfilePhoto(String url,String userId);
  Future<bool> updateGroupProfilePhoto(String url,String groupID);
  Future<List<UserModel>> getAllUser();
  Stream<List<Message>> getMessages(String currentUserID,String chattedUserID);
  Stream<List<Message>> getGroupMessages(String currentUserID,String chattedUserID);
  Future<bool> saveMessage(Message saveMessage);
  Future<bool> saveGroupMessage(Message saveMessage);
  Stream<List<Speech>> getAllConversations(String userID);
  Stream<List<GroupSpeech>> getAllGroupConversation(String userID);
  Future<bool> addStatus(String url,String userId,String description);
  Future<bool> createNews(News news);
  Future<List<News>> getAllNews();
  Future<bool> createGroup(Group group);
  Future<void>  updateMembers(List<dynamic> members,String groupID);

}