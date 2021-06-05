import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kbu_app/model/Story.dart';
import 'package:kbu_app/model/activity.dart';
import 'package:kbu_app/model/group.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/model/groupSpeech.dart';
import 'package:kbu_app/model/speech.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/repository/user_repository.dart';
import 'package:kbu_app/services/auth_base.dart';
import 'package:kbu_app/services/locator.dart';

enum ViewState { Idle, Busy }

class UserViewModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.Idle;
  UserRepository _userRepository = locator<UserRepository>();
  UserModel _user;
  String emailMessage;
  String passwordMessage;

   List<UserModel> allUserList = [];

  UserModel get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserViewModel() {
    currentUser();
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.currentUser();
      if(_user!= null)
      return _user;
      else return null;
    } catch (e) {
      debugPrint("View modeldeki current user da hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      _user = null;
      return await _userRepository.signOut();
    } catch (e) {
      debugPrint("View modeldeki signout da hata:" + e.toString());
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }
  

  @override
  Future<UserModel> signInAnonymusly() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInAnonymusly();
      return _user;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        state = ViewState.Busy;
        _user = await _userRepository.createUserWithEmailandPassword(
            email, password);
        return _user;
      } else
        return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithEmailandPassword(
      String email, String password) async {
    try {
      if (_emailPasswordControl(email, password)) {
        state = ViewState.Busy;
        _user =
            await _userRepository.signInWithEmailandPassword(email, password);
        return _user;
      } else
        return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      debugPrint("Viewmodeldeki current user hata:" + e.toString());
      return null;
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailPasswordControl(String email, String password) {
    var result = true;
    if (password.length < 6) {
      passwordMessage = "Şifreniz En Az Altı Karakter Olmalı";
      result = false;
    } else
      passwordMessage = null;

    if (!email.contains('@ogrenci.karabuk.edu.tr')) {
      emailMessage =
          "Geçersiz E-Mail Adresi Lütfen Karabük Üniversitesi Mail Adresinizi Kullanın";
      result = false;
    } else
      emailMessage = null;

    return result;
  }

  Future<bool> updateUserName(String userID, String newUserName) async {
    var result = await _userRepository.updateUserName(userID, newUserName);
    if(result){
      _user.userName = newUserName;
    }
    return result;
  }

  Future<String>uploadFile(String userID, String fileType, File profilePhoto) async{
    var url = await _userRepository.uploadFile(userID, fileType,profilePhoto);
    return url;
  }

  Future<List<UserModel>> getAllUser() async{
     allUserList = await _userRepository.getAllUser();
    return allUserList;
  }

  Stream<List<Message>>getMessages(String currentUserID, String chattedUserID) {
    return _userRepository.getMessages(currentUserID,chattedUserID);
  }

  Stream<List<Speech>>getAllConversation(String userID) {
    return _userRepository.getAllConversation(userID);
  }
  Stream<List<GroupSpeech>>getAllGroupConversation(String userID) {
    return _userRepository.getAllGroupConversation(userID);
  }
  UserModel findUserInList(String userID){
    for(int i=0;i<allUserList.length;i++){
      if(allUserList[i].userID == userID){
        return allUserList[i];
      }
    }
    return null;
  }

  Future<String>uploadStory(String userID, String fileType, File profilePhoto,String description) async{
    var url = await _userRepository.uploadStory(userID, fileType,profilePhoto,description);
    return url;
  }

  Stream<List<Story>>getAllStory() {
    return _userRepository.getAllStory();
  }

  UserModel findUserInListByName(String userName){
    for(int i=0;i<allUserList.length;i++){
      if(allUserList[i].userName == userName){
        return allUserList[i];
      }
    }
    return null;
  }

  void deleteConversation(List<String> deletedConversation) {
     _userRepository.deleteConversation(deletedConversation);
  }

  Future<String> uploadNewsFile(
      String documentID, String fileType, File haberFoto) async {
    var indirmeLinki =
    await _userRepository.uploadNewsFile(documentID, fileType, haberFoto);
    return indirmeLinki;
  }

  Future<bool> createNews(News news) async {
    var sonuc = await _userRepository.createNews(news);
    return sonuc;
  }

  Future<List<News>> getAllNews() async {
    var tumHaberlerListesi = await _userRepository.getAllNews();
    return tumHaberlerListesi;
  }

  Future<bool>  createActivity(Activity activity) async{
    var sonuc = await _userRepository.createActivity(activity);
    return sonuc;
  }

  Future<List<Activity>> getAllActivity() async{
    var tumHaberlerListesi = await _userRepository.getAllActivity();
    return tumHaberlerListesi;
  }

  Future<String> uploadGroupFile(
      String documentID, String fileType, File haberFoto, String description) async {
    var groupImgUrl =
    await _userRepository.uploadGroupFile(documentID, fileType, haberFoto,description);
    return groupImgUrl;
  }

  Future<bool> createGroup(Group group) async {
    var result = await _userRepository.createGroup(group);
    return result;
  }

  Future<String>updateGroupPhoto(String documentID, String fileType, File haberFoto, String description) async{
    var groupImgUrl =
    await _userRepository.updateGroupPhoto(documentID, fileType, haberFoto,description);
    return groupImgUrl;
  }

  Future<void>updateMembers(List<dynamic> members,String groupID) async{
    await _userRepository.updateMembers(members,groupID);
  }

}
