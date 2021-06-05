import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/activity.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/screens/activity/CreateActivity.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/custom-drawer.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      /*  leading:IconButton(
      icon: Icon(
        Icons.notifications,
        color:Colors.white,
      ),
      onPressed: (){},
      ),*/
      title: Text(getTranslated(context, "Activities")),
      actions: [
        Builder(
            builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer(); //popup menü
                  },
                )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel _userModel = Provider.of<UserViewModel>(context);
    UserModel user = _userModel.user;
    return Scaffold(
      backgroundColor: UniversalVeriables.bg,
      endDrawer: CustomDrawer(),
      appBar: customAppBar(context),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: FutureBuilder<List<Activity>>(
                future: _userModel.getAllActivity(),
                builder: (context, result) {
                  if (result.hasData) {
                    var allActivity = result.data;
                    if (allActivity.length > 0) {
                      return RefreshIndicator(
                        onRefresh: _updateActivityList,
                        child: ListView.builder(
                          itemCount: allActivity.length,
                          itemBuilder: (context, index) {
                            var activity = result.data[index];
                            if (activity != null) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            UniversalVeriables.seperatorColor,
                                        width: context.dynamicWidth(0.001),
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: context.paddingAllLoww,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            width: context.dynamicWidth(0.02)),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                activity.title,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ResponsiveFlutter.of(
                                                              context)
                                                          .fontSize(2.5),
                                                  color: UniversalVeriables
                                                      .appBarColor,
                                                ),
                                              ),
                                              SizedBox(
                                                  height: context
                                                      .dynamicHeight(0.01)),
                                              Column(
                                                children: [
                                                  Text(
                                                    activity.content,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(2),
                                                      color: UniversalVeriables
                                                          .greyColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    activity.date,
                                                    style: TextStyle(
                                                      fontSize:
                                                          ResponsiveFlutter.of(
                                                                  context)
                                                              .fontSize(1.5),
                                                      color: UniversalVeriables
                                                          .greyColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                      return RefreshIndicator(
                        onRefresh: _updateActivityList,
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
                                    color: UniversalVeriables.buttonColor,
                                    size: 120,
                                  ),
                                  Text(
                                    getTranslated(context, "No Events Yet"),
                                    style: TextStyle(
                                        fontSize: ResponsiveFlutter.of(context)
                                            .fontSize(5),
                                        color: UniversalVeriables.greyColor),
                                  ),
                                ],
                              ),
                            ),
                            height: MediaQuery.of(context).size.height - 150,
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: addActivity(context, user.role),
    );
  }

  Future<Null> _updateActivityList() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }

  Widget addActivity(BuildContext context, String role) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff0353a4), Color(0xff0353a4)],
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateActivity()),
            );
          },
        ),
        padding: context.paddingAllLow,
      ),
    );
  }
}
