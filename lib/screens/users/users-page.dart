import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/screens/users/userSearch.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/chat_view_model.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../chat/chat_screen.dart';
import '../group/newGroupPage.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(getTranslated(context, "Select Person")),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            showSearch(context: context, delegate: UsersSeacrh());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var supportService = connectSupport();
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
        backgroundColor: UniversalVeriables.bg,
        appBar: customAppBar(context),
        body: Column(
          //bu kısmın kaydırılmasını istemiyoruz
          children: [
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade900))),
              child: Theme(
                data: ThemeData(splashColor: UniversalVeriables.blueColor),
                child: ListTile(
                  title: Text(
                    getTranslated(context, "Create a Group"),
                    style: TextStyle(
                      color: UniversalVeriables.tabColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.25),
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.group,
                      color: UniversalVeriables.tabColor,
                      size: 32,
                    ),
                    radius: 30,
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultipleSelectItems()),
                    );
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade900))),
              child: Theme(
                data: ThemeData(splashColor: UniversalVeriables.blueColor),
                child: ListTile(
                  title: Text(
                    getTranslated(context, "Unika Support"),
                    style: TextStyle(
                      color: UniversalVeriables.tabColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.25),
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.support_agent,
                      color: UniversalVeriables.tabColor,
                      size: 32,
                    ),
                    radius: 30,
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context, rootNavigator: false)
                        .push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  builder: (context) => ChatViewModel(
                                      currentUser: _userModel.user,
                                      chattedUser: supportService),
                                  child: ChatScreen(),
                                )));
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade900))),
              child: Theme(
                data: ThemeData(splashColor: UniversalVeriables.blueColor),
                child: ListTile(
                  title: Text(
                    "Rimer",
                    style: TextStyle(
                      color: UniversalVeriables.tabColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.25),
                    ),
                  ),
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.business,
                      color: UniversalVeriables.tabColor,
                      size: 32,
                    ),
                    radius: 30,
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () => _launchURL(),
                ),
              ),
            ),
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
            padding: context.paddingAllLow,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allUser.length,
              itemBuilder: (context, index) {
                if (allUser[index].userID != _userModel.user.userID &&
                    allUser[index].role != "Admin" &&
                    allUser[index].role != "Support") {
                  return Padding(
                    padding: context.paddingAllLow,
                    child: Theme(
                      data: ThemeData(
                        splashColor: UniversalVeriables.blueColor,
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context, rootNavigator: false)
                              .push(MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        builder: (context) => ChatViewModel(
                                            currentUser: _userModel.user,
                                            chattedUser: allUser[index]),
                                        child: ChatScreen(),
                                      )));
                        },
                        title: Text(
                          allUser[index].userName,
                          style: TextStyle(
                            color: UniversalVeriables.greyColor,
                            fontSize: ResponsiveFlutter.of(context).fontSize(2),
                          ),
                        ),
                        subtitle: Text(
                          allUser[index].email,
                          style: TextStyle(
                            color: UniversalVeriables.greyColor,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.5),
                          ),
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
                      color: UniversalVeriables.appBarColor,
                      size: 120,
                    ),
                    Text(
                      getTranslated(context, "No user yet"),
                      style: TextStyle(
                        color: UniversalVeriables.appBarColor,
                        fontSize: ResponsiveFlutter.of(context).fontSize(5),
                      ),
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

  UserModel connectSupport() {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    UserModel user = _userModel.findUserInListByName("UNİKA DESTEK");
    print(user);
    return user;
  }

  _launchURL() async {
    var url = 'https://rimer.karabuk.edu.tr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
