import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';

import 'widgets/PicturePageViewWidget.dart';
import 'widgets/ProfileAppBar.dart';
import 'widgets/ProfileBottomAppBarWidget.dart';
import 'widgets/ProfileDraggableCardWidget.dart';

class IPhoneXSocialAppDesign extends StatefulWidget {
  @override
  _IPhoneXSocialAppDesignState createState() => _IPhoneXSocialAppDesignState();
}

StreamController<double> controller = StreamController.broadcast();

class _IPhoneXSocialAppDesignState extends State<IPhoneXSocialAppDesign>
    with SingleTickerProviderStateMixin {
  double position = 0.40;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return SafeArea(
          child: Stack(
        children: <Widget>[
          PicturePageViewWidget(
              profilePictureImage: "assets/ivana_cajina_unsplash.jpg",
              dragPosition: position),
          ProfileAppBar(),
          StreamBuilder(
              stream: controller.stream,
              builder: (context, snapshot) {
                return NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    position = notification.extent;
                    setState(() {});
                    return true;
                  },
                  child: ScrollConfiguration(
                    behavior: GlowLessScrollBehavior(),
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.40,
                      minChildSize: 0.40,
                      maxChildSize: 0.60,
                      expand: true,
                      builder: (BuildContext context,
                          ScrollController scrollController) {
                        return SingleChildScrollView(
                          controller: scrollController,
                          child: ProfileDraggableCardWidget(),
                        );
                      },
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: ProfileBottomAppBarWidget(),
          )
        ],
      ));
    });
  }
}

class GlowLessScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
