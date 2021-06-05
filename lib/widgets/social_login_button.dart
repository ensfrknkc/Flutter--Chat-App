import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class SocialLoginButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double height;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.butonText,
      this.butonColor: Colors.red,
      this.textColor: Colors.white,
      this.radius: 16, //ön tanımlı değer girilmezse kullanılır
      this.height: 20,
      this.butonIcon,
      this.onPressed})
      : assert(butonText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (butonIcon != null) ...[
              butonIcon,
              Text(
                butonText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
              ),
              Opacity(opacity: 0, child: butonIcon)
            ],
            if (butonIcon == null) ...[
              Container(),
              Text(
                butonText,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: ResponsiveFlutter.of(context).fontSize(2)),
              ),
              Opacity(opacity: 0, child: Container())
            ]
          ],
        ),
        color: butonColor,
      ),
    );
  }
}
