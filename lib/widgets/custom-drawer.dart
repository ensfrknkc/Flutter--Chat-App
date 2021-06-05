import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/screens/document/document.dart';
import 'package:kbu_app/screens/visit/visit.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import '../screens/admin/adminSettingsPage.dart';
import '../screens/communication/CommunicationPage.dart';
import '../screens/profile/profile_page.dart';
import '../screens/transportation/TransportationPage.dart';
import 'CustomListTile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    return Drawer(
      child: Expanded(
        child: Container(
          color: UniversalVeriables.customDrawerColor,
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => ProfilePage()));
                },
                child: DrawerHeader(
                  decoration: BoxDecoration(),
                  child: FittedBox(
                    child: Container(
                      child: Column(
                        children: [
                          Material(
                            borderRadius:
                                BorderRadius.all(Radius.circular(65.0)),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor: UniversalVeriables.blueColor,
                              backgroundImage:
                                  NetworkImage(_userModel.user.profileURL),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CustomListTile(
                  Icons.person,
                  getTranslated(context, "Profile"),
                  () => {
                        Navigator.of(context).pop(),
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => ProfilePage()))
                      }),
              CustomListTile(
                  Icons.phone,
                  getTranslated(context, "Communication"),
                  () => {
                        Navigator.of(context).pop(),
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => CommunicationPage()))
                      }),
              CustomListTile(
                  Icons.navigation,
                  getTranslated(context, "How can I go ?"),
                  () => {
                        Navigator.of(context).pop(),
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => TransportationPage()))
                      }),
              CustomListTile(
                  Icons.directions_walk,
                  getTranslated(context, "Places to visit"),
                  () => {
                        Navigator.of(context).pop(),
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => VisitPage()))
                      }),
              CustomListTile(
                  Icons.business,
                  getTranslated(context, "Documents"),
                  () => {
                        Navigator.of(context).pop(),
                        Navigator.of(context).push(MaterialPageRoute(
                            fullscreenDialog: false,
                            builder: (context) => DocumentPage()))
                      }),
              _userModel.user.role.contains("Admin")
                  ? CustomListTile(
                      Icons.admin_panel_settings,
                      getTranslated(context, "Admin Operations"),
                      () => {
                            Navigator.of(context).pop(),
                            Navigator.of(context).push(MaterialPageRoute(
                                fullscreenDialog: false,
                                builder: (context) => AdminSettingsPage()))
                          })
                  : Container(),
              CustomListTile(
                  Icons.settings,
                  getTranslated(context, "Settings"),
                  () => {
                        Navigator.of(context).pop(),
                      }),
              CustomListTile(Icons.lock, getTranslated(context, "Sign out"),
                  () => {_signOutPermission(context)}),
            ],
          ),
        ),
      ),
    );
  }

  Future _signOutPermission(BuildContext context) async {
    final result = await PlatformAlertDialog(
      title: getTranslated(context, "Are you sure?"),
      content: getTranslated(context, "Are you sure you want to log out?"),
      mainAction: getTranslated(context, "Yes"),
      secondAction: getTranslated(context, "Cancel"),
    ).show(context);

    if (result == true) {
      _signOut(context);
    }
  }

  Future<bool> _signOut(BuildContext context) async {
    try {
      final _userModel = Provider.of<UserViewModel>(context);
      bool sonuc = await _userModel.signOut();
      return sonuc;
    } catch (e) {
      debugPrint("call page signout hata");
      return false;
    }
  }
}

// ignore: must_be_immutable
