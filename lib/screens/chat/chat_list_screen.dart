import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:kbu_app/localization/language.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/main.dart';
import 'package:kbu_app/model/speech.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/chat_view_model.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/custom-drawer.dart';
import 'package:kbu_app/widgets/new_chat_button.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'chat_screen.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class ChatListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatListScreenState();
  }
}

List<Widget> getState;

class _ChatListScreenState extends State {
  var theSelected = [];

  CustomAppBar customAppBar(BuildContext context) {
    return theSelected.length < 1
        ? CustomAppBar(
            /*  leading:IconButton(
      icon: Icon(
        Icons.notifications,
        color:Colors.white,
      ),
      onPressed: (){},
      ),*/
            title: Text(getTranslated(context, "Chat")),
            actions: [
              DropdownButton(
                onChanged: (Language language) {
                  _changeLanguage(language);
                },
                underline: SizedBox(),
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                ),
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                          value: lang,
                          child: Row(
                            children: [Text(lang.flag), Text(lang.name)],
                          ),
                        ))
                    .toList(),
              ),
              Builder(
                  builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      )),
            ],
          )
        : CustomAppBar(
            /*  leading:IconButton(
      icon: Icon(
        Icons.notifications,
        color:Colors.white,
      ),
      onPressed: (){},
      ),*/
            title: Text(theSelected.length.toString()),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                onPressed: () {
                  deleteConversation();
                },
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    final UserViewModel _userModel = Provider.of<UserViewModel>(context);
    var _time = "";
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      endDrawer: CustomDrawer(),
      appBar: customAppBar(context),
      body: Center(
        child: StreamBuilder<List<Speech>>(
          stream: _userModel.getAllConversation(_userModel.user.userID),
          builder: (context, streamConversationList) {
            if (!streamConversationList.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<Speech> allConversation = streamConversationList.data;
            return ListView.builder(
              itemCount: allConversation.length,
              reverse: false,
              itemBuilder: (context, index) {
                var userInList = _userModel
                    .findUserInList((allConversation[index].chatWith));
                if (userInList != null) {
                  print("veriler locale cacheden okundu");
                  allConversation[index].chattedUserName = userInList.userName;
                  allConversation[index].chattedUserProfileUrl =
                      userInList.profileURL;
                  try {
                    _time = _showTime(
                        allConversation[index].createDate ?? Timestamp(1, 1));
                  } catch (e) {
                    print("Hata var: " + e.toString());
                  }
                  return Padding(
                    padding: context.paddingAllLow,
                    child: Theme(
                      data: ThemeData(
                        splashColor: UniversalVeriables.signInColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade900))),
                        child: Container(
                          color: theSelected
                                  .contains(allConversation[index].chatWith)
                              ? UniversalVeriables.signInColor
                              : UniversalVeriables.bg,
                          child: Dismissible(
                            background: Container(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              color: UniversalVeriables.signInColor,
                            ),
                            key: Key(UniqueKey().toString()),
                            onDismissed: (direction) {
                              theSelected.add(allConversation[index].chatWith);
                              deleteConversation();
                            },
                            child: ListTile(
                              onLongPress: () {
                                setState(() {
                                  if (theSelected.contains(
                                      allConversation[index].chatWith)) {
                                    print("çıkarıldı");
                                    theSelected.remove(
                                        allConversation[index].chatWith);
                                  } else {
                                    print("eklendi");
                                    theSelected
                                        .add(allConversation[index].chatWith);
                                  }
                                });

                                print("long presss");
                              },
                              onTap: () {
                                if (theSelected.length > 0) {
                                  setState(() {
                                    if (theSelected.contains(
                                        allConversation[index].chatWith)) {
                                      print("çıkarıldı");
                                      theSelected.remove(
                                          allConversation[index].chatWith);
                                    } else {
                                      print("eklendi");
                                      theSelected
                                          .add(allConversation[index].chatWith);
                                    }
                                  });

                                  print("long presss");
                                } else {
                                  Navigator.of(context, rootNavigator: false)
                                      .push(MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  ChangeNotifierProvider(
                                                    builder: (context) => ChatViewModel(
                                                        currentUser:
                                                            _userModel.user,
                                                        chattedUser: _userModel
                                                            .findUserInList(
                                                                allConversation[
                                                                        index]
                                                                    .chatWith)),
                                                    child: ChatScreen(),
                                                  )));
                                }
                              },
                              title: Text(
                                allConversation[index].chattedUserName,
                                style: TextStyle(
                                  color: UniversalVeriables.appBarColor,
                                  fontSize: ResponsiveFlutter.of(context)
                                      .fontSize(2.25),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: (allConversation[index]
                                          .lastMessage
                                          .length <
                                      40)
                                  ? Text(
                                      allConversation[index].lastMessage,
                                      style: TextStyle(
                                        color: UniversalVeriables.greyColor,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(1.75),
                                      ),
                                    )
                                  : Text(
                                      allConversation[index]
                                              .lastMessage
                                              .substring(0, 39) +
                                          "....",
                                      style: TextStyle(
                                        color: UniversalVeriables.greyColor,
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(1.75),
                                      ),
                                    ),
                              leading: CircleAvatar(
                                backgroundColor: UniversalVeriables.bg,
                                backgroundImage: NetworkImage(
                                    allConversation[index]
                                        .chattedUserProfileUrl),
                                radius: 30,
                              ),
                              trailing: (Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Opacity(
                                    opacity: 0,
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: context.dynamicHeight(0.01),
                                  ),
                                  Text(
                                    _time,
                                    style: TextStyle(
                                      color: UniversalVeriables.greyColor,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.5),
                                    ),
                                  )
                                ],
                              )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: NewChatButton(),
    );
  }

  String _showTime(Timestamp date) {
    DateTime _time = DateTime.now();
    var duration = _time.difference(date.toDate());
    String difference = timeago.format((_time.subtract(duration)));
    print(difference);
    var _formattedDate;

    if (difference.contains("hour") | difference.contains("hours")) {
      var _formatterHour = DateFormat.Hm();
      _formattedDate = _formatterHour.format(date.toDate());
    } else if (difference.contains("moment") | difference.contains("minutes")) {
      var _formatterHour = DateFormat.Hm();
      _formattedDate = _formatterHour.format(date.toDate());
    } else {
      var _formatterDay = DateFormat.d();
      var _formatterMonth = DateFormat.M();
      var _formatterYear = DateFormat.y();
      var _formattedDateDay = _formatterDay.format(date.toDate());
      var _formattedDateMonth = _formatterMonth.format(date.toDate());
      var _formatterDateYear = _formatterYear.format(date.toDate());
      _formattedDate = _formattedDateDay +
          "." +
          _formattedDateMonth +
          "." +
          _formatterDateYear;
    }
    return _formattedDate;
  }

  Future<void> deleteConversation() async {
    final UserViewModel _userModel = Provider.of<UserViewModel>(context);
    List<String> deletedConversation = new List();
    String chattedUser;
    for (var i in theSelected) {
      chattedUser = _userModel.user.userID + "--" + i;
      deletedConversation.add(chattedUser);
    }
    _userModel.deleteConversation(deletedConversation);
    setState(() {
      theSelected.clear();
    });
  }

  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
    MyApp.setLocale(context, _temp);
  }
}
