import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class ProfileBottomAppBarWidget extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    var margin = screenSizeInfo.paddingSmall * 0.5;
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(screenSizeInfo.paddingMedium * 1.5),
        margin: EdgeInsets.fromLTRB(margin, 0, margin, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenSizeInfo.paddingMedium),
            topLeft: Radius.circular(screenSizeInfo.paddingMedium),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.contact_phone,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.redAccent,
                ),
                onPressed: () {}),
            FloatingActionButton(
              onPressed: () {},
              mini: true,
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.redAccent,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.message,
                  color: Colors.grey,
                ),
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
