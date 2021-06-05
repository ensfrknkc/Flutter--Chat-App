import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem{Message,Call,Status}

class TabItemData{
  final String title;
  final IconData icon;

  TabItemData(this.title, this.icon);

  static Map<TabItem,TabItemData> allTabs = {
    TabItem.Message: TabItemData("CHAT",Icons.chat),
    TabItem.Call: TabItemData("CALL",Icons.call),
    TabItem.Status: TabItemData("STATUS",Icons.contact_phone),
  };

}