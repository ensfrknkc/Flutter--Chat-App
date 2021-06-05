import 'package:flutter/material.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:provider/provider.dart';
import '../home/home_screen.dart';
import 'sign_in_page.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);

    if(_userModel.state == ViewState.Idle){
      if(_userModel.user == null){
        return SignInPage();
      }else{
         getAllUser(context);
        return HomeScreen();
      }
    }else{
      return Scaffold(
        body:Center(child: CircularProgressIndicator(),) ,
      );
    }

  }

  void getAllUser(BuildContext context) async{
    final _userModel = Provider.of<UserViewModel>(context);
    await _userModel.getAllUser();
  }
}
