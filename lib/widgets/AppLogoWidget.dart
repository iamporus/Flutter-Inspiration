import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';

import 'BaseStatelessWidget.dart';

class AppLogoWidget extends BaseStatelessWidget {
  final double radius;
  final double padding;

  const AppLogoWidget({
    @required this.radius,
    this.padding,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Image(
            image: AssetImage("assets/app_logo_512.webp"),
          ),
        ),
      ),
    );
  }
}
