import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class ProfileAppBar extends BaseStatelessWidget {
  const ProfileAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
        height: screenSizeInfo.screenHeight * 0.10,
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
