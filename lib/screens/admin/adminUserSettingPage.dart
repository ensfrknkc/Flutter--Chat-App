import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:provider/provider.dart';


class AdminUserSettingsPage extends StatefulWidget {
  @override
  _AdminUserSettingsPageState createState() => _AdminUserSettingsPageState();
}

class _AdminUserSettingsPageState extends State<AdminUserSettingsPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UniversalVeriables.bg,
        appBar:AppBar(
          title: Text(getTranslated(context, "User Operations")),
          backgroundColor: UniversalVeriables.bg,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              child: Expanded(
                child: createUserList(),
              ),
            ),
          ],
        ));
  }

  Widget createUserList() {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    if (_userModel.allUserList.isNotEmpty) {
      var allUser = _userModel.allUserList;
      if (allUser.length - 1 > 0) {
        return RefreshIndicator(
          onRefresh: _usersListUpdate,
          child: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allUser.length,
              itemBuilder: (context, index) {
                if (allUser[index].userID != _userModel.user.userID && allUser[index].role != "Admin") {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Theme(
                      data: ThemeData(
                        splashColor: UniversalVeriables.blueColor,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);

                        },
                        title: Text(
                          allUser[index].userName,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        subtitle: Text(
                          allUser[index].email,
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: UniversalVeriables.bg,
                          backgroundImage: NetworkImage(
                            allUser[index].profileURL,
                          ),
                          radius: 30,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      } else {
        return RefreshIndicator(
          onRefresh: _usersListUpdate,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.supervised_user_circle,
                      color: UniversalVeriables.onlineDoctColor,
                      size: 120,
                    ),
                    Text(
                      getTranslated(context, "No users yet"),
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<Null> _usersListUpdate() async {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    await _userModel.getAllUser();
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }
}
