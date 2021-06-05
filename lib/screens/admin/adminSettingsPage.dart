import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/widgets/CustomListTile.dart';

import 'adminUserSettingPage.dart';

class AdminSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        title: Text(getTranslated(context, "Admin Operations")),
        backgroundColor: UniversalVeriables.bg,
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
              child: CustomListTile(Icons.supervised_user_circle, getTranslated(context, "User Operations"), () => {
                Navigator.of(context).pop(),
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: false,
                    builder: (context) => AdminUserSettingsPage()))
              }),
            ),
          ],
        ),
      ),

    );
  }
}
