import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/screens/group/createGroupPage.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class MultipleSelectItems extends StatefulWidget {
  @override
  _MultipleSelectItemsState createState() => _MultipleSelectItemsState();
}

class _MultipleSelectItemsState extends State<MultipleSelectItems> {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(getTranslated(context, "Add members")),
    );
  }
  var theSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UniversalVeriables.bg,
        appBar: customAppBar(context),
        body: Column(
          children: [
            Container(
              child: Expanded(
                child: createUserList(),
              ),
            ),
          ],
        ),
      floatingActionButton:addMember(context, theSelected),
    );

  }


  Widget createUserList() {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    if (_userModel.allUserList.isNotEmpty) {
      var allUser = _userModel.allUserList;
      if (allUser.length - 1 > 0) {
        return Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allUser.length,
            itemBuilder: (context, index) {
               if (allUser[index].userID != _userModel.user.userID && !allUser[index].role.contains("Admin") && !allUser[index].role.contains("Support")) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Theme(
                    data: ThemeData(
                      splashColor: UniversalVeriables.blueColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (theSelected.contains(allUser[index].userID)) {
                            print("????kar??ld??");
                            theSelected.remove(allUser[index].userID);
                          }
                          else {
                            print("eklendi");
                            theSelected.add(allUser[index].userID);
                          }
                        });
                      },
                      child: Container(
                        color: theSelected.contains(allUser[index].userID)
                            ? UniversalVeriables.blueColor
                            : UniversalVeriables.bg,
                        child: ListTile(
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
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      } else {
        return SingleChildScrollView(
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
        );
      }
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget addMember(BuildContext context, List theSelected) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff00b6f3), Color(0xff0184dc)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(50),
        ),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CreateGroup(selectedUsers: theSelected)),
            );
          },
        ),
        padding: EdgeInsets.all(1),
      ),
    );
  }
}