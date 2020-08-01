import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_4_iphone_x_social_app/StateCurrentPage.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:provider/provider.dart';

import 'UserProfile.dart';
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
  List<UserProfile> userProfiles;
  UserProfile selectedProfile;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    userProfiles = getDummyUserProfiles();
    selectedProfile = userProfiles.first;
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
          child: ChangeNotifierProvider(
            create: (_) => StateCurrentPage(),
            child: Stack(
              children: <Widget>[
                PicturePageViewWidget(
                  userProfiles: userProfiles,
                  dragPosition: position,
                ),
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
                            maxChildSize: 0.68,
                            expand: true,
                            builder: (BuildContext context,
                                ScrollController scrollController) {
                              return SingleChildScrollView(
                                controller: scrollController,
                                child: ProfileDraggableCardWidget(
                                  dragPosition: position,
                                  userProfiles: userProfiles,
                                ),
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
            ),
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
