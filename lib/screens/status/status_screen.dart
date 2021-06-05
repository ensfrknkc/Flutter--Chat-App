import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/Story.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/custom-drawer.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'store_page_view.dart';
import 'story_add.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  File _statusPhoto;
  var _time;
  final picker = ImagePicker();

  void _takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _statusPhoto = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => StoryAdd(_statusPhoto)));
  }

  void chooseGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _statusPhoto = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => StoryAdd(_statusPhoto)));
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      /*  leading:IconButton(
      icon: Icon(
        Icons.notifications,
        color:Colors.white,
      ),
      onPressed: (){},
      ),*/
      title: Text(getTranslated(context, "Announcements")),
      actions: [
        /*IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),*/
        Builder(
            builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserViewModel _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      endDrawer: CustomDrawer(),
      appBar: customAppBar(context),
      body: Center(
          child: Container(
        color: UniversalVeriables.bg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userModel.user.role.contains("Admin")
                ? GestureDetector(
                    onTap: () {
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
                                            color:
                                                UniversalVeriables.greyColor)),
                                    onTap: () {
                                      chooseGallery();
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Card(
                      color: UniversalVeriables.bg,
                      elevation: 0.0,
                      child: Padding(
                        padding: context.paddingAllLow,
                        child: ListTile(
                          leading: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor:UniversalVeriables.appBarColor ,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                radius: 30,
                              ),

                            ],
                          ),
                          title: Text(
                            "Duyurular",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: UniversalVeriables.appBarColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(2.5),
                            ),
                          ),
                          subtitle: Text(
                            "Duyuru eklemek için dokunun",
                            style: TextStyle(
                              color: UniversalVeriables.greyColor,
                              fontSize:
                                  ResponsiveFlutter.of(context).fontSize(1.75),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            _userModel.user.role.contains("Admin")
                ? Padding(
                    padding: context.paddingAllLow2,
                    child: Text(
                      getTranslated(context, "Added announcements"),
                      style: TextStyle(
                        color: UniversalVeriables.appBarColor,
                        fontWeight: FontWeight.bold,
                        fontSize: ResponsiveFlutter.of(context).fontSize(2.5),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Center(
                child: StreamBuilder<List<Story>>(
                  stream: _userModel.getAllStory(),
                  builder: (context, streamConversationList) {
                    if (!streamConversationList.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List<Story> allStories = streamConversationList.data;
                    return ListView.builder(
                      itemCount: allStories.length,
                      reverse: false,
                      itemBuilder: (context, index) {
                        try {
                          _time = _showTime(
                              allStories[index].date ?? Timestamp(1, 1));
                          print(allStories[index].description);
                        } catch (e) {
                          print("Hata var: " + e.toString());
                        }
                        return Padding(
                          padding: context.paddingAllLow,
                          child: Theme(
                            data: ThemeData(
                              splashColor: UniversalVeriables.blueColor,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade900))),
                              padding: context.paddingAllLow,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(allStories[index].storyUrl),
                                ),
                                title: Text(
                                  allStories[index].description,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(2),
                                      color: UniversalVeriables.greyColor),
                                ),
                                subtitle: Text(
                                  _time,
                                  style: TextStyle(
                                      fontSize: ResponsiveFlutter.of(context)
                                          .fontSize(1.5),
                                      color: UniversalVeriables.greyColor),
                                ),
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoryPageView(
                                            allStories[index].storyUrl))),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  String _showTime(Timestamp date) {
    var _formatter = DateFormat.Hm();
    var _formattedDate = _formatter.format(date.toDate());
    return _formattedDate;
  }
}
