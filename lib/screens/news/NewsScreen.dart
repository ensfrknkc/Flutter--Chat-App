import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/custom-drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'create_news_page.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      /*  leading:IconButton(
      icon: Icon(
        Icons.notifications,
        color:Colors.white,
      ),
      onPressed: (){},
      ),*/
      title: Text(getTranslated(context, "News")),
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
              child: FutureBuilder<List<News>>(
                future: _userModel.getAllNews(),
                builder: (context, result) {
                  if (result.hasData) {
                    var allNews = result.data;
                    if (allNews.length > 0) {
                      return RefreshIndicator(
                        onRefresh: _newsListUpdate,
                        child: ListView.builder(
                          itemCount: allNews.length,
                          itemBuilder: (context, index) {
                            var news = result.data[index];
                            if (news != null) {
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
                                  margin: context.marginAllLow,
                                  child: Padding(
                                    padding: context.paddingAllLoww,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: context.dynamicWidth(0.2),
                                          height: context.dynamicHeight(0.2),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(news.imgURL),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        SizedBox(
                                          width: context.dynamicWidth(0.01),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                news.title,
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
                                                height:
                                                    context.dynamicHeight(0.01),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    news.content,
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
                        onRefresh: _newsListUpdate,
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
                                    getTranslated(context, "No news yet"),
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
      floatingActionButton: addNews(context, user.role),
    );
  }

  Future<Null> _newsListUpdate() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }

  Widget addNews(BuildContext context, String role) {
    if (role == "Admin") {
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
                MaterialPageRoute(builder: (context) => CreateNews()),
              );
            },
          ),
          padding: context.paddingAllLow,
        ),
      );
    } else {
      return Container();
    }
  }
}
