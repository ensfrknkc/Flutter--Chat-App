import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/news.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/app_bar.dart';
import 'package:kbu_app/widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';

// ignore: must_be_immutable
class CreateNews extends StatefulWidget {
  var selectedUsers = [];
  CreateNews({this.selectedUsers});
  @override
  _CreateNewsState createState() => _CreateNewsState();
}

class _CreateNewsState extends State<CreateNews> {
  TextEditingController newsTitleController = TextEditingController();
  TextEditingController newsContentController = TextEditingController();

  File _newsFoto;
  final picker = ImagePicker();
  News _news;

  void _olustur(String title, String content) async {
    final _userModel = Provider.of<UserViewModel>(context);
    _news = News(
      title: title,
      content: content,
      documentName: title + randomSayiUret(),
    );
    if (_newsFoto != null) {
      var url = await _userModel.uploadNewsFile(
          _news.documentName, "news_foto", _newsFoto);
      print("Gelen url :" + url);
      _news.imgURL = url;
    }
    _userModel.createNews(_news);
  }

  Future _kameradanFotoCek() async {
    final _yeniResim = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _newsFoto = File(_yeniResim.path);
      Navigator.of(context).pop();
    });
  }

  Future _galeridenResimSec() async {
    var _yeniResim = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _newsFoto = File(_yeniResim.path);
      Navigator.of(context).pop();
    });
  }

  String randomSayiUret() {
    int rasgeleSayi = Random().nextInt(999999);
    return rasgeleSayi.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UniversalVeriables.bg,
        appBar: customAppBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: context.dynamicHeight(0.1),
                ),
                Padding(
                  padding: context.paddingAllLow,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: context.dynamicHeight(0.2),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text(getTranslated(
                                        context, "Capture From Camera")),
                                    onTap: () {
                                      _kameradanFotoCek();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text(getTranslated(
                                        context, "Select From Gallery")),
                                    onTap: () {
                                      _galeridenResimSec();
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
                      backgroundImage: _newsFoto == null
                          ? NetworkImage(
                              "https://www.karabuk.edu.tr/wp-content/themes/kbu/assets/images/logo.png")
                          : FileImage(_newsFoto),
                    ),
                  ),
                ),
                Padding(
                  padding: context.paddingAllLow,
                  child: Form(
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: UniversalVeriables.greyColor),
                          controller: newsTitleController,
                          decoration: InputDecoration(
                            hintText: getTranslated(context, "Title"),
                            labelText: getTranslated(context, "Title"),
                            labelStyle: TextStyle(
                                color: UniversalVeriables.appBarColor),
                            hintStyle:
                                TextStyle(color: UniversalVeriables.greyColor),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.1),
                        ),
                        TextField(
                          style: TextStyle(color: UniversalVeriables.greyColor),
                          controller: newsContentController,
                          maxLength: 500,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: getTranslated(context, "Content"),
                            labelText: getTranslated(context, "Content"),
                            labelStyle: TextStyle(
                                color: UniversalVeriables.appBarColor),
                            hintStyle:
                                TextStyle(color: UniversalVeriables.greyColor),
                            enabledBorder: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.dynamicHeight(0.1),
                        ),
                        SocialLoginButton(
                          butonText: getTranslated(context, "Create"),
                          butonColor: UniversalVeriables.buttonColor,
                          radius: 10,
                          butonIcon: Opacity(
                            opacity: 0,
                            child: Icon(
                              Icons.email,
                              size: 30,
                              color: UniversalVeriables.greyColor,
                            ),
                          ),
                          height: context.dynamicHeight(0.1),
                          onPressed: () => {
                            _olustur(newsTitleController.text,
                                newsContentController.text),
                            Navigator.pop(context),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

CustomAppBar customAppBar(BuildContext context) {
  return CustomAppBar(
    actions: [],
    title: Text(getTranslated(context, "Create News")),
  );
}
