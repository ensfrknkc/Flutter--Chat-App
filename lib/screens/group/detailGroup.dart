import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/screens/profile/profile_photo.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/groupChat_view_model.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:kbu_app/widgets/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'addParticipant.dart';

class GroupDetailPage extends StatefulWidget {
  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  File _profilePhoto;
  final picker = ImagePicker();
  void _takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _profilePhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
    });
  }

  void chooseGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profilePhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
    });
  }
  List<UserModel> membersInformation = List<UserModel>();

  @override
  Widget build(BuildContext context) {
    final _chatModel = Provider.of<GroupChatViewModel>(context);
    List<dynamic> members = _chatModel.group.members;

    final _userModel = Provider.of<UserViewModel>(context);
    print(members);
    for (var member in members) {
      UserModel user = _userModel.findUserInList(member);
      print(user);
      membersInformation.add(user);
    }

    print(membersInformation);
    return Scaffold(
      appBar: AppBar(
        title: Text(_chatModel.group.groupName),
        centerTitle: true,
        backgroundColor: UniversalVeriables.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                Padding(padding: context.paddingAllLow),
                GestureDetector(
                  onTap: () {
                    showImage(_chatModel.group.groupImgUrl);
                  },
                  child: Container(
                    width: context.dynamicWidth(0.95),
                    height: context.dynamicHeight(0.6),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _profilePhoto==null ? NetworkImage(_chatModel.group.groupImgUrl):FileImage(_profilePhoto),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.circular(8.0),
                    ),
                  ),
                ),

                IconButton(
                  onPressed: (){
                    if(_profilePhoto==null){
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              color: UniversalVeriables.bg,
                              height: context.dynamicHeight(0.3),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.camera_alt,
                                      color: UniversalVeriables.greyColor,
                                    ),
                                    title: Text(
                                      getTranslated(
                                          context, "Capture From Camera"),
                                      style: TextStyle(
                                          color: UniversalVeriables.greyColor),
                                    ),
                                    onTap: () {
                                      _takePhoto();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.image,
                                      color: UniversalVeriables.greyColor,
                                    ),
                                    title: Text(
                                        getTranslated(
                                            context, "Select From Gallery"),
                                        style: TextStyle(
                                            color: UniversalVeriables.greyColor)),
                                    onTap: () {
                                      chooseGallery();
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    }else{
                      setState(() {
                        _profilePhotoUpdate(context,_chatModel);
                      });

                    }
                  },
                  icon: _profilePhoto==null ? Icon(

                    Icons.camera_alt_rounded,
                    color: Colors.grey,
                  ):Icon(

                    Icons.save,
                    color: Colors.grey,
                  ),
                  iconSize: 30,
                ),
                   SizedBox(
                     height: context.dynamicHeight(0.1),
                   ),
                   Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:context.paddingLeft,
                          child: Text(
                            "Katılımcılar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: UniversalVeriables.appBarColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.25),
                            ),
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: members.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: context.paddingAllLow,
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          membersInformation[index].profileURL)),
                                  title: Text(
                                    membersInformation[index].userName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: UniversalVeriables.appBarColor,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                    ),
                                  ),
                                  subtitle: Text(
                                    membersInformation[index].email,
                                    style: TextStyle(
                                      color: UniversalVeriables.greyColor,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.5),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Divider(
                          color: Colors.grey,
                          height: context.dynamicHeight(0.1),
                        ),
                        GestureDetector(
                          onTap: (){
                            members.add(_chatModel.group.administrator);
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) => AddParticipant(members,_chatModel.group.docId)));
                          },
                          child: ListTile(
                            leading: Icon(
                              Icons.group_add,
                              color: UniversalVeriables.buttonColor,
                            ),
                            title: Text(getTranslated(
                                context, "Add Participant"),
                                style: TextStyle(
                                  color: UniversalVeriables.appBarColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: context.dynamicHeight(0.1),
                        ),
                        GestureDetector(
                          onTap: (){
                            return showDialog(
                                context: context,
                                builder: (builder) => AlertDialog(
                              title: Text(getTranslated(
                                  context, "Are you sure?")),
                              content: Text(getTranslated(
                            context, "You are about to leave the group")),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    updateMembers(members,_chatModel);
                                  },
                                  child: Text(getTranslated(
                                      context, "Yes")),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(getTranslated(
                                      context, "No")),
                                ),
                              ],
                            ),
                            );

                          },
                          child: ListTile(
                            leading:  Icon(
                                Icons.outbox,
                                color: Colors.red,
                              ),

                            title: Text(getTranslated(
                                context, "Exit Group"),
                                style: TextStyle(
                                  color: UniversalVeriables.appBarColor,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          height: context.dynamicHeight(0.1),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ),
      ),
    );
  }
  void showImage(String profilePhoto) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => ProfilePhoto(profilePhoto)));
  }
  void _profilePhotoUpdate(BuildContext context,final _chatModel) async {
    final _userModel = Provider.of<UserViewModel>(context);
    if (_profilePhoto != null) {
      var url = await _userModel.updateGroupPhoto(_chatModel.group.docId, "group_img", _profilePhoto, "group_Img.png");
      _chatModel.group.groupImgUrl = url;
      print("gelen url" + url);
      if (url != null) {
        PlatformAlertDialog(
          title: getTranslated(context, "Successful"),
          content: getTranslated(context, "Profile Picture Changed"),
          mainAction: getTranslated(context, "Ok"),
        ).show(context);
      }
    }
  }

  void updateMembers(List<dynamic> members,final _chatModel) async{
    final _userModel = Provider.of<UserViewModel>(context);
    members.remove(_userModel.user.userID);
    await _userModel.updateMembers(members,_chatModel.group.docId);
    Future.delayed(Duration(milliseconds: 1), () {
      Navigator.of(context).popUntil(ModalRoute.withName("/"));
    });
  }
}
