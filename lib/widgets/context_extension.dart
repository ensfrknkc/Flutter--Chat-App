import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.width * val;
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAllLow => EdgeInsets.all(dynamicHeight(0.01));
  EdgeInsets get paddingAllLoww => EdgeInsets.all(dynamicHeight(0.025));
  EdgeInsets get paddingAllLoww3 => EdgeInsets.all(dynamicHeight(0.5));
  EdgeInsets get paddingAllLowww => EdgeInsets.fromLTRB(dynamicHeight(0.0),
      dynamicHeight(0.025), dynamicHeight(0.025), dynamicHeight(0.025));
  EdgeInsets get paddingAllLow2 => EdgeInsets.fromLTRB(dynamicHeight(0.07),
      dynamicHeight(0.01), dynamicHeight(0.01), dynamicHeight(0.01));
  EdgeInsets get paddingAllLowTop => EdgeInsets.fromLTRB(dynamicHeight(0.01),
      dynamicHeight(0.4), dynamicHeight(0.01), dynamicHeight(0.01));

  EdgeInsets get paddingAllLowTopSign => EdgeInsets.fromLTRB(dynamicHeight(0.01),
      dynamicHeight(0.2), dynamicHeight(0.01), dynamicHeight(0.01));
  EdgeInsets get paddingAllLowe => EdgeInsets.fromLTRB(dynamicHeight(0.01),
      dynamicHeight(0.1), dynamicHeight(0.01), dynamicHeight(0.1));
  EdgeInsets get paddingLeft => EdgeInsets.fromLTRB(dynamicHeight(0.05),
      dynamicHeight(0.0), dynamicHeight(0.0), dynamicHeight(0.0));
}

extension MarginExtension on BuildContext {
  EdgeInsets get marginAllLow => EdgeInsets.all(dynamicHeight(0.01));
}

//extension SizeExtension on BuildContext {}