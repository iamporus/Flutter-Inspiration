import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class PlantShopAppBar extends BaseStatelessWidget {
  final Icon leadingIcon;

  final Icon shopActionIcon;

  const PlantShopAppBar({
    Key key,
    @required this.leadingIcon,
    @required this.shopActionIcon,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingMedium, 0, 0, 0),
        child: IconButton(
            icon: leadingIcon,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, screenSizeInfo.paddingMedium, 0),
          child: CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black.withAlpha(15),
            child: IconButton(
                icon: shopActionIcon,
                onPressed: () {}),
          ),
        )
      ],
    );
  }
}
