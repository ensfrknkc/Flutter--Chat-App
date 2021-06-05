import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  PlatformAlertDialog(
      {@required this.title,
      @required this.content,
      @required this.mainAction,
      this.secondAction});

  final String title;
  final String content;
  final String mainAction;
  final String secondAction;

  @override
  Widget buildAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _button(context),
    );
  }

  @override
  Widget buildIOsWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _button(context),
    );
  }

  List<Widget> _button(BuildContext context) {
    final allButton = <Widget>[];

    if (Platform.isIOS) {
      if (secondAction != null) {
        allButton.add(CupertinoDialogAction(
          child: Text(secondAction),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ));
      }
      allButton.add(CupertinoDialogAction(
        child: Text(mainAction),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ));
    } else {
      if (secondAction != null) {
        allButton.add(FlatButton(
          child: Text(secondAction),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ));
      }

      allButton.add(FlatButton(
        child: Text(mainAction),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ));
    }

    return allButton;
  }

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog<bool>(
            context: context, builder: (content) => this)
        : await showDialog<bool>(context: context, builder: (content) => this);
  }
}
