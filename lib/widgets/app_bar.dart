import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;

  const CustomAppBar({
    Key key,
    @required this.title,
    @required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingAllLow,
      decoration: BoxDecoration(
          color: UniversalVeriables.appBarColor,
          border: Border(
              bottom: BorderSide(
            color: UniversalVeriables.seperatorColor,
            width: 1.4,
            style: BorderStyle.solid,
          ))),
      child: AppBar(
        backgroundColor: UniversalVeriables.appBarColor,
        elevation: 0,
        actions: actions,
        title: title,
      ),
    );
  }

  final Size preferredSize = const Size.fromHeight(kToolbarHeight + 10);
}
