import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/notification_handler.dart';
import 'package:kbu_app/screens/activity/activityScreen.dart';
import 'package:kbu_app/screens/group/groupChatListScreen.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import '../news/newsScreen.dart';
import '../chat/chat_list_screen.dart';
import '../status/status_screen.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationHandler().initializeFcmNotification(context);
    pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_page == 0) {
          SystemNavigator.pop();
          return false;
        } else {
          onPageChanged(0);
          navigationTapped(0);
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: UniversalVeriables.bg,
        body: PageView(
          children: [
            Center(
              child: ChatListScreen(),
            ),
            Center(
              child: GroupChatListScreen(),
            ),
            Center(
              child: NewsPage(),
            ),
            Center(
              child: ActivityScreen(),
            ),
            Center(
              child: StatusScreen(),
            ),
          ],
          controller: pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: Container(
          child: Padding(
            padding: context.paddingAllLow,
            child: CupertinoTabBar(
              backgroundColor: UniversalVeriables.bg,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat,
                        // ignore: unrelated_type_equality_checks
                        color: (_page == 0)
                            ? UniversalVeriables.tabColor
                            : UniversalVeriables.greyColor),
                    // ignore: deprecated_member_use
                    title: Text(
                      getTranslated(context, "Chat"),
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1),
                          // ignore: unrelated_type_equality_checks
                          color: (_page == 0)
                              ? UniversalVeriables.tabColor
                              : UniversalVeriables.greyColor),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group,
                        // ignore: unrelated_type_equality_checks
                        color: (_page == 1)
                            ? UniversalVeriables.tabColor
                            : UniversalVeriables.greyColor),
                    // ignore: deprecated_member_use
                    title: Text(
                      getTranslated(context, "Groups"),
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1),
                          // ignore: unrelated_type_equality_checks
                          color: (_page == 1)
                              ? UniversalVeriables.tabColor
                              : UniversalVeriables.greyColor),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications,
                        // ignore: unrelated_type_equality_checks
                        color: (_page == 2)
                            ? UniversalVeriables.tabColor
                            : UniversalVeriables.greyColor),
                    // ignore: deprecated_member_use
                    title: Text(
                      getTranslated(context, "News"),
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1),
                          // ignore: unrelated_type_equality_checks
                          color: (_page == 2)
                              ? UniversalVeriables.tabColor
                              : UniversalVeriables.greyColor),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_activity_outlined,
                        // ignore: unrelated_type_equality_checks
                        color: (_page == 3)
                            ? UniversalVeriables.tabColor
                            : UniversalVeriables.greyColor),
                    // ignore: deprecated_member_use
                    title: Text(
                      getTranslated(context, "Activities"),
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1),
                          // ignore: unrelated_type_equality_checks
                          color: (_page == 3)
                              ? UniversalVeriables.tabColor
                              : UniversalVeriables.greyColor),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.announcement,
                        // ignore: unrelated_type_equality_checks
                        color: (_page == 4)
                            ? UniversalVeriables.tabColor
                            : UniversalVeriables.greyColor),
                    // ignore: deprecated_member_use
                    title: Text(
                      getTranslated(context, "Announcements"),
                      style: TextStyle(
                          fontSize: ResponsiveFlutter.of(context).fontSize(1),
                          // ignore: unrelated_type_equality_checks
                          color: (_page == 4)
                              ? UniversalVeriables.tabColor
                              : UniversalVeriables.greyColor),
                    )),
              ],
              onTap: navigationTapped,
              currentIndex: _page,
            ),
          ),
        ),
      ),
    );
  }
}

