import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/message.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isWriting = false;
  var _messageController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final _chatModel = Provider.of<ChatViewModel>(context);
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          child: CircleAvatar(
            backgroundColor: UniversalVeriables.bg,
            backgroundImage: NetworkImage(_chatModel.chattedUser.profileURL),
          ),
        ),
        backgroundColor: UniversalVeriables.appBarColor,
        title: Text(
          _chatModel.chattedUser.userName,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _chatModel.state == ChatViewState.Busy
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  buildMessageList(),
                  chatControls(),
                ],
              ),
            ),
    );
  }

  Widget buildMessageList() {

    return Consumer<ChatViewModel>(
      builder: (context, chatModel, child) {
        return Expanded(
          child: ListView.builder(
            controller: _scrollController,
            reverse: true,
            itemBuilder: (context, index) {
              if (chatModel.hasMoreLoading &&
                  chatModel.messageList.length == index) {
                return _loadingNewElements();
              } else
                return _createSpeechBubble(chatModel.messageList[index]);
            },
            itemCount: chatModel.hasMoreLoading
                ? chatModel.messageList.length + 1
                : chatModel.messageList.length,
          ),
        );
      },
    );
  }

  Widget chatControls() {
    setWritingTo(bool value) {
      setState(() {
        isWriting = value;
      });
    }

    final _chatModel = Provider.of<ChatViewModel>(context);

    UserModel _currentUser = _chatModel.currentUser;
    UserModel _chattedUser = _chatModel.chattedUser;

    return _chattedUser.role.contains("Admin")
        ? Container()
        : Container(
            color: UniversalVeriables.bg,
            height: context.dynamicHeight(0.1),
            padding: context.paddingAllLow,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      (value.length > 0 && value.trim() != "")
                          ? setWritingTo(true)
                          : setWritingTo(false);
                    },
                    controller: _messageController,
                    cursorColor: Colors.blueGrey,
                    style: new TextStyle(
                        fontSize: ResponsiveFlutter.of(context).fontSize(2),
                        color: UniversalVeriables.appBarColor),
                    decoration: InputDecoration(
                        prefixIcon: GestureDetector(
                          child: Icon(
                            Icons.emoji_emotions_sharp,
                            size: 30,
                            color: Colors.grey,
                          ),
                          onTap: () {},
                        ),
                        fillColor: UniversalVeriables.bg,
                        filled: true,
                        hintText: getTranslated(context, "Write a message"),
                        hintStyle:
                            TextStyle(color: UniversalVeriables.greyColor),
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: BorderSide.none)),
                  ),
                ),
                isWriting
                    ? Container()
                    : Padding(
                        padding: context.paddingAllLow,
                        child: InkWell(
                          child: Icon(
                            Icons.attach_file,
                            size: 30,
                            color: UniversalVeriables.greyColor,
                          ),
                          onTap: () {},
                        ),
                      ),
                isWriting
                    ? Container()
                    : Padding(
                        padding: context.paddingAllLow,
                        child: InkWell(
                          child: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: UniversalVeriables.greyColor,
                          ),
                          onTap: () {},
                        ),
                      ),
                isWriting
                    ? Padding(
                        padding: context.paddingAllLow,
                        child: Container(
                            color: Colors.transparent,
                            margin: context.marginAllLow,
                            child: InkWell(
                              child: Icon(
                                Icons.send,
                                size: 30,
                                color: UniversalVeriables.appBarColor,
                              ),
                              onTap: () async {
                                if (_messageController.text.trim().length > 0) {
                                  Message _saveMessage = Message(
                                    fromWho: _currentUser.userID,
                                    who: _chattedUser.userID,
                                    fromMe: true,
                                    message: _messageController.text,
                                  );
                                  var result = await _chatModel.saveMessage(
                                      _saveMessage, _currentUser);
                                  if (result) {
                                    _messageController.clear();
                                    setWritingTo(false);
                                    _scrollController.animateTo(0.0,
                                        duration:
                                            const Duration(milliseconds: 30),
                                        curve: Curves.easeOut);
                                  }
                                }
                              },
                            )),
                      )
                    : Container()
              ],
            ),
          );
  }

  //BURAYA BAKKK

  Widget _createSpeechBubble(Message currentMessage) {
    final _chatModel = Provider.of<ChatViewModel>(context);
    Color _incomingMessageColor = UniversalVeriables.receiverColor;
    Color _goingMessageColor = UniversalVeriables.buttonColor;

    var _time = "";

    try {
      _time = _showTime(currentMessage.date ?? Timestamp(1, 1));
    } catch (e) {
      print("Hata var: " + e.toString());
    }

    var _fromMe = currentMessage.fromMe;
    if (_fromMe) {
      return Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: _goingMessageColor,
                    ),
                    padding: context.paddingAllLoww,
                    margin: context.marginAllLow,
                    child: Stack(overflow: Overflow.visible, children: [
                      Padding(
                        padding: context.paddingAllLoww,
                        child: Text(
                          currentMessage.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -6.0,
                          right: 0.0,
                          child: Row(
                            children: <Widget>[
                              Text(_time,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.5),
                                  )),
                            ],
                          )),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(_chatModel.chattedUser.profileURL),
                ),
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: _incomingMessageColor,
                    ),
                    padding: context.paddingAllLoww,
                    margin: context.marginAllLow,
                    child: Stack(overflow: Overflow.visible, children: [
                      Padding(
                        padding: context.paddingAllLoww,
                        child: Text(
                          currentMessage.message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -6.0,
                          right: 0.0,
                          child: Row(
                            children: <Widget>[
                              Text(_time,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveFlutter.of(context)
                                        .fontSize(1.5),
                                  )),
                            ],
                          )),
                    ]),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  String _showTime(Timestamp date) {
    var _formatter = DateFormat.Hm();
    var _formattedDate = _formatter.format(date.toDate());
    return _formattedDate;
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      bringOldMessages();
    }
  }

  void bringOldMessages() async {
    final _chatModel = Provider.of<ChatViewModel>(context);
    if (_isLoading == false) {
      _isLoading = true;
      await _chatModel.bringOldMessages();
      _isLoading = false;
    }
  }

  _loadingNewElements() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
