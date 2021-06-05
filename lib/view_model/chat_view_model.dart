import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/repository/user_repository.dart';
import 'package:kbu_app/services/locator.dart';

enum ChatViewState{Idle,Loaded,Busy}

class ChatViewModel with ChangeNotifier{

  List<Message> _allMessage;
  ChatViewState _state = ChatViewState.Idle;
  static final total =15;
  UserRepository _userRepository = locator<UserRepository>();
  final UserModel currentUser;
  final UserModel chattedUser;
  Message _lastMessage;
  Message _firstMessageInList;
  bool _hasMore = true;
  bool get hasMoreLoading =>_hasMore;
  bool _newMessageListener =false;
  StreamSubscription _streamSubscription;

  ChatViewModel({this.currentUser, this.chattedUser}){
    _allMessage = [];
    getMessageWithPagination(false);
  }

  List<Message> get messageList => _allMessage;
  ChatViewState get state =>_state;

  set state (ChatViewState value){
    _state = value;
    notifyListeners();
  }
  @override
  dispose(){
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<bool> saveMessage(Message saveMessage,UserModel currentUser) async{
    return await _userRepository.saveMessage(saveMessage,currentUser);
  }
  void getMessageWithPagination(bool yeniMesajlarGetiriliyor) async {
    if(_allMessage.length>0){
      _lastMessage = _allMessage.last;

    }
    if(!yeniMesajlarGetiriliyor)
      state =ChatViewState.Busy;

    var comingMessage = await _userRepository.getMessageWithPagination(
        currentUser.userID, chattedUser.userID, _lastMessage, total);

    if(comingMessage.length<total){
      _hasMore =false;
    }

    _allMessage.addAll(comingMessage);
    if(_allMessage.length>0){
    _firstMessageInList = _allMessage.first;}
    state = ChatViewState.Loaded;

    if(_newMessageListener ==false){
      _newMessageListener =true;
      print("Listener yok o yüzden atancak");
      newMessageListenerAssign();
    }
  }

  Future<void>bringOldMessages () async{
    print("Daha fazla mesaj getir tetiklendi-viewmodeldeyiz");
    if(_hasMore){
      getMessageWithPagination(true);
    }
    else{
      print("daha fazla mesaj yok ");
      await Future.delayed(Duration(seconds: 2));
    }
  }

  void newMessageListenerAssign() {
    print("Listener yeni mesjlar için atandı");
    _streamSubscription=_userRepository.getMessages(currentUser.userID, chattedUser.userID).listen((currentData) {
      if(currentData.isNotEmpty){
        print("Listener tetiklendi ve son getirilen veri:"+currentData[0].toString());

        if(currentData[0].date!=null){

          if(_firstMessageInList == null){
            _allMessage.insert(0, currentData[0]);
          }else if(_firstMessageInList.date.millisecondsSinceEpoch != currentData[0].date.millisecondsSinceEpoch){
            _allMessage.insert(0, currentData[0]);}
        }
        state = ChatViewState.Loaded;
      }
    });
  }

}