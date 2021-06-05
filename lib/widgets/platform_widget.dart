import 'dart:io';

import 'package:flutter/cupertino.dart';

abstract class PlatformWidget extends StatelessWidget {

  Widget buildAndroidWidget(BuildContext context);
  Widget buildIOsWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return buildIOsWidget(context);
    }
    return buildAndroidWidget(context);
  }
}
