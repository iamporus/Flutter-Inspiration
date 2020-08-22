import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';

import 'BaseStatelessWidget.dart';

enum AppLogoAnim { IDLE, SPINNING }

extension ExtractAnimType on AppLogoAnim {
  String toAnimName() {
    return this.toString().toLowerCase().split('.').last;
  }
}

class AppLogoWidget extends BaseStatelessWidget {
  final double radius;
  final AppLogoAnim anim;

  const AppLogoWidget({
    @required this.radius,
    @required this.anim,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Center(
      child: CircleAvatar(
        radius: radius,
        child: FlareActor(
          "assets/app_logo_anim.flr",
          animation: anim.toAnimName(),
        ),
      ),
    );
  }
}
