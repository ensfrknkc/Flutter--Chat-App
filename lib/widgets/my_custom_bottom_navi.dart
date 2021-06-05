import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/tab_item.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class MyCustomBottomNavi extends StatelessWidget {
  const MyCustomBottomNavi(
      {Key key,
      @required this.currentTab,
      @required this.onSelectedTab,
      @required this.pageCreater,
      @required this.navigatorKey})
      : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pageCreater;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKey;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        backgroundColor: UniversalVeriables.bg,
        tabBar: CupertinoTabBar(
          backgroundColor: UniversalVeriables.bg,
          items: [
            _navItemCreate(TabItem.Message),
            _navItemCreate(TabItem.Call),
            _navItemCreate(TabItem.Status),
          ],
          onTap: (index) => onSelectedTab(TabItem.values[index]),
        ),
        tabBuilder: (context, index) {
          final displayItem = TabItem.values[index];
          return CupertinoTabView(
            navigatorKey: navigatorKey[displayItem],
            builder: (context) {
              return pageCreater[displayItem];
            },
          );
        });
  }

  BottomNavigationBarItem _navItemCreate(TabItem tabItem) {
    final currentTab = TabItemData.allTabs[tabItem];

    return BottomNavigationBarItem(
      icon: Icon(currentTab.icon,
          // ignore: unrelated_type_equality_checks
          color: UniversalVeriables.tabColor),
      // ignore: deprecated_member_use
      title: Text(
        currentTab.title,
        style: TextStyle(
            fontSize: ResponsiveFlutter.of(context).fontSize(1.75),
            // ignore: unrelated_type_equality_checks
            color: UniversalVeriables.tabColor),
      ),
    );
  }
}
