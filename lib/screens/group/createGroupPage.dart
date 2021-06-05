import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/group.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/screens/group/groupChatScreen.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/groupChat_view_model.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/social_login_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CreateGroup extends StatefulWidget {
  var selectedUsers = [];

  CreateGroup({this.selectedUsers});

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  TextEditingController groupNameController = TextEditingController();
  File _groupImg;
  final picker = ImagePicker();
  Group _group;
  UserModel user;
  Future<Widget> _createGroup(String groupName)  async{
    var url;
    final _userModel = Provider.of<UserViewModel>(context);
    _group = Group(
      docId: groupNameController.text + "--" + Random().nextInt(4294967296).toString(),
      groupName: groupNameController.text,
      role: "Group",
      administrator: user.userID,
      members: widget.selectedUsers,
    );
    widget.selectedUsers.add(user.userID);
    if (_groupImg != null) {
       url = await _userModel.uploadGroupFile(
          _group.groupName, "group_img", _groupImg, "group_Img.png");
      print("Group Image Url :" + url);
       _group.groupImgUrl = url;
    }
   setState(() {
     _userModel.createGroup(_group);
   });
    if(url != null){
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: false)
          .push(MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            builder: (context) => GroupChatViewModel(
                currentUser: _userModel.user,
                chattedUser: UserModel.idAndImage(userID: _group.docId, profileURL: _group.groupImgUrl, userName: _group.groupName,role:_group.role)),
            child: GroupChatScreen(),
          )));
    }
    else{
      return Center(child: CircularProgressIndicator());
    }

  }

  Future _shootWithCamera() async {
    final _newGroupImg = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _groupImg = File(_newGroupImg.path);
      Navigator.of(context).pop();
    });
  }

  Future _chooseFromGallery() async {
    var _newGroupImg = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _groupImg = File(_newGroupImg.path);
      Navigator.of(context).pop();
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(getTranslated(context, "Create a Group")),
    );
  }
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
     user =_userModel.user;

    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 170,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text(getTranslated(
                                      context, "Capture From Camera")),
                                  onTap: () {
                                    _shootWithCamera();
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image),
                                  title: Text(getTranslated(
                                      context, "Select From Gallery")),
                                  onTap: () {
                                    _chooseFromGallery();
                                  },
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    backgroundImage: _groupImg == null
                        ? NetworkImage(
                        "https://img.favpng.com/25/7/19/users-group-computer-icons-png-favpng-WKWD9rqs5kwcviNe9am7xgiPx.jpg")
                        : FileImage(_groupImg),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(color: Colors.grey),
                        controller: groupNameController,
                        decoration: InputDecoration(

                          hintText: getTranslated(context, "Group Name"),
                          labelText: getTranslated(context, "Group Name"),
                          labelStyle: TextStyle(color: Colors.grey),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SocialLoginButton(
                        butonText: getTranslated(context, "Create"),
                        butonColor: Colors.blueAccent,
                        radius: 10,
                        butonIcon: Opacity(
                          opacity: 0,
                          child: Icon(

                            Icons.email,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        height: 40,
                        onPressed: () => {
                          _createGroup(groupNameController.text),
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
