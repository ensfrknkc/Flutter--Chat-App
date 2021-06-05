import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/utils/universal_veriables.dart';

import '../screens/users/users-page.dart';

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UniversalVeriables.buttonColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(
          Icons.edit,
          color: Colors.white,
          size: 30,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UsersPage()));
        },
      ),
      padding: EdgeInsets.all(1),
    );
  }
}
