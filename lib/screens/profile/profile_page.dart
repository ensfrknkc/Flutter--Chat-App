import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/platform_alert_dialog.dart';
import 'package:kbu_app/widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'profile_photo.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _profilePhoto;
  final picker = ImagePicker();
  TextEditingController _controllerUserName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerUserName = TextEditingController();
  }

  @override
  void dispose() {
    _controllerUserName.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    _controllerUserName.text = _userModel.user.userName;
    print("profil sayfasındaki değerler" + _userModel.user.toString());
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      appBar: AppBar(
        title: Text(getTranslated(context, "Profile")),
        backgroundColor: UniversalVeriables.appBarColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: context.paddingAllLow,
                child: GestureDetector(
                  onTap: () {
                    showImage(_userModel.user.profileURL);
                  },
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: UniversalVeriables.blueColor,
                    backgroundImage: _profilePhoto == null
                        ? NetworkImage(_userModel.user.profileURL)
                        : FileImage(_profilePhoto),
                  ),
                ),
              ),
              Opacity(
                opacity: 1,
                child: IconButton(
                  icon: Icon(
                    Icons.camera_alt,
                    color: UniversalVeriables.greyColor,
                  ),
                  focusColor: UniversalVeriables.blueColor,
                  highlightColor: UniversalVeriables.blueColor,
                  hoverColor: UniversalVeriables.blueColor,
                  splashColor: UniversalVeriables.blueColor,
                  disabledColor: UniversalVeriables.blueColor,
                  color: UniversalVeriables.greyColor,
                  iconSize: 30,
                  onPressed: () {
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
                  },
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              Padding(
                padding: context.paddingAllLow,
                child: TextFormField(
                  style: TextStyle(color: UniversalVeriables.greyColor),
                  initialValue: _userModel.user.email,
                  readOnly: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon:
                        Icon(Icons.mail, color: UniversalVeriables.greyColor),
                    hintText: getTranslated(context, "E-Mail"),
                    hintStyle: TextStyle(
                      color: UniversalVeriables.greyColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                    ),
                    labelText: getTranslated(context, "E-Mail"),
                    labelStyle: TextStyle(
                      color: UniversalVeriables.appBarColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: context.paddingAllLow,
                child: TextFormField(
                  controller: _controllerUserName,
                  style: TextStyle(color: UniversalVeriables.greyColor),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon: Opacity(
                        opacity: 1,
                        child: Icon(Icons.person,
                            color: UniversalVeriables.greyColor)),
                    suffixIcon:
                        Icon(Icons.edit, color: UniversalVeriables.greyColor),
                    hintText: getTranslated(context, "User Name"),
                    hintStyle: TextStyle(
                      color: UniversalVeriables.greyColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(1.5),
                    ),
                    labelText: getTranslated(context, "User Name"),
                    labelStyle: TextStyle(
                      color: UniversalVeriables.appBarColor,
                      fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              Padding(
                padding: context.paddingAllLow,
                child: SocialLoginButton(
                  butonText: getTranslated(context, "Save"),
                  butonColor: UniversalVeriables.buttonColor,
                  onPressed: () {
                    _userNameUpdate(context);
                    _profilePhotoUpdate(context);
                  },
                  height: context.dynamicHeight(0.1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _userNameUpdate(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context);
    if (_userModel.user.userName != _controllerUserName.text) {
      var updateResult = await _userModel.updateUserName(
          _userModel.user.userID, _controllerUserName.text);
      if (updateResult == true) {
        PlatformAlertDialog(
          title: getTranslated(context, "Successful"),
          content: getTranslated(context, "Username Changed"),
          mainAction: getTranslated(context, "Ok"),
        ).show(context);
      } else {
        _controllerUserName.text = _userModel.user.userName;
        PlatformAlertDialog(
          title: getTranslated(context, "Error"),
          content: getTranslated(
              context, "Username is taken, please try another username"),
          mainAction: getTranslated(context, "Ok"),
        ).show(context);
      }
    }
  }

  void _profilePhotoUpdate(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context);
    if (_profilePhoto != null) {
      var url = await _userModel.uploadFile(
          _userModel.user.userID, "profil_foto", _profilePhoto);
      _userModel.user.profileURL = url;
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

  void showImage(String profilePhoto) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => ProfilePhoto(profilePhoto)));
  }
}
