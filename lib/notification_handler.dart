import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kbu_app/view_model/chat_view_model.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';

import 'model/user_model.dart';
import 'screens/chat/chat_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
   
    final dynamic data = message['data'];
    print("arka planda gelen data:" + message["data"].toString());
    print("arka planda gelen data2:" + data["isim"].toString());
    NotificationHandler._showMessagingNotification(message);

  }

  return Future<void>.value();
}

class NotificationHandler {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static final NotificationHandler _singleton = NotificationHandler._internal();
  factory NotificationHandler() {
    return _singleton;
  }

  NotificationHandler._internal();
  BuildContext mycontext;

  initializeFcmNotification(BuildContext context) async {
    mycontext =context;
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIos = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIos);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    _firebaseMessaging.onTokenRefresh.listen((newToken) async{
      User _currentUser=await Future.value(FirebaseAuth.instance.currentUser);
      await FirebaseFirestore.instance.doc("tokens/"+_currentUser.uid).set({"token":newToken});
    });

    _firebaseMessaging.configure(
  
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showMessagingNotification(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  static Future<void> _showMessagingNotification(Map<String, dynamic> message) async {

    //final String largeIconPath = await _downloadAndSaveFile(
       // message["data"]["profilURL"], 'largeIcon');

    Person me = Person(
      name: message["data"]["title"],
      key: '1',
      //icon: BitmapFilePathAndroidIcon(largeIconPath),
    );


    final MessagingStyleInformation messagingStyle = MessagingStyleInformation(
        me,
        messages: [Message(message["data"]["message"], DateTime.now(), me)]);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('1234', 'Yeni mesaj', 'your channel description',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        category: 'msg', styleInformation: messagingStyle);
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, message["data"]["title"], message["data"]["message"], platformChannelSpecifics,
        payload: jsonEncode(message));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) {
    return null;
  }

  Future onSelectNotification(String payload) async{
    final UserViewModel _userModel = Provider.of<UserViewModel>(mycontext);
    if (payload != null) {
      debugPrint('notification payload: $payload');
      Map<String,dynamic> comingNotification = await jsonDecode(payload);

      Navigator.of(mycontext, rootNavigator: false)
          .push(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            builder: (context) => ChatViewModel(currentUser: _userModel.user,chattedUser:UserModel.idAndImage(
                userID:
                comingNotification["data"]["senderUserID"],
                profileURL: comingNotification["data"]["profilURL"],
                userName:comingNotification["data"]["title"] ) ),
            child: ChatScreen(),
          )));

      return null;
    }
    return null;
  }

  static _downloadAndSaveFile(String url,String fileName) async{
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(url);
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

}
