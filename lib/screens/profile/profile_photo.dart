import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:kbu_app/view_model/user_viewModel.dart';
import 'package:kbu_app/widgets/context_extension.dart';

class ProfilePhoto extends StatelessWidget {

  String url;
  ProfilePhoto(String url){
    this.url =url;
  }


  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Container(
      height: context.dynamicHeight(0.01),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
