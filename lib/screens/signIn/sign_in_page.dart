import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbu_app/localization/localization_constants.dart';
import 'package:kbu_app/model/user_model.dart';
import 'package:kbu_app/screens/signIn/signin_with_email.dart';
import 'package:kbu_app/utils/universal_veriables.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/widgets/context_extension.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  /*void _guestLogin(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context);
    await Firebase.initializeApp();
    UserModel user = await _userModel.signInAnonymusly();
    print("oturum açan user id :" + user.userID.toString());
  }*/

  void _signInEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => EmailLogin()));
  }

  void _signInGoogle(BuildContext context) async {
    final _userModel = Provider.of<UserViewModel>(context);
    UserModel _user = await _userModel.signInWithGoogle();
    if (_user != null) print("oturum açan user id:" + _user.userID.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Center(
            child: new Text(
              "Unicapp",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ResponsiveFlutter.of(context).fontSize(3.5),
              ),
            )),
        elevation: 0,
        backgroundColor: UniversalVeriables.appBarColor,
      ),
      backgroundColor: UniversalVeriables.bg,
      body: SingleChildScrollView(
        child: Padding(
          padding: context.paddingAllLowTopSign,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: context.dynamicWidth(0.95),
                height: context.dynamicHeight(0.6),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/logobizim.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius:
                  BorderRadius.circular(8.0),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.1),
              ),
              FittedBox(
                child: SocialLoginButton(
                  butonColor: UniversalVeriables.customDrawerColor,
                  onPressed: () => _signInGoogle(context),
                  butonIcon: Image(
                    height: context.dynamicHeight(0.1),
                    image: AssetImage("image/gmail.png"),
                  ),
                  butonText:
                  getTranslated(context, "Sign in with Gmail and Password"),
                  //farklı mail adresi ile olan
                  textColor: Colors.white,
                  radius: 16,
                  height: context.dynamicHeight(0.1),
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              FittedBox(
                child: SocialLoginButton(
                  butonColor: UniversalVeriables.customDrawerColor,
                  butonText:
                  getTranslated(context, "Sign in with Email and Password"),
                  textColor: Colors.white,
                  radius: 16,
                  onPressed: () {
                    _signInEmail(context);
                  },
                  height: context.dynamicHeight(0.1),
                  butonIcon: Image(
                    height: context.dynamicHeight(0.1),
                    image: AssetImage("image/kbu.png"),
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
