import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_4_iphone_x_social_app/StateCurrentPage.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:flutter_design_challenge/widgets/ShowUpTransitionWidget.dart';
import 'package:provider/provider.dart';

import '../UserProfile.dart';

class ProfileDraggableCardWidget extends StatefulWidget {
  final double dragPosition;
  final List<UserProfile> userProfiles;

  const ProfileDraggableCardWidget({
    Key key,
    @required this.dragPosition,
    @required this.userProfiles,
  }) : super(key: key);

  @override
  _ProfileDraggableCardWidgetState createState() =>
      _ProfileDraggableCardWidgetState();
}

class _ProfileDraggableCardWidgetState
    extends State<ProfileDraggableCardWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Consumer<StateCurrentPage>(
        builder: (context, profileModel, _) {
          var currentProfile = widget.userProfiles[profileModel.currentPage];

          return Material(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.transparent,
                  height: screenSizeInfo.screenHeight * 0.08,
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(screenSizeInfo.paddingLarge),
                      topLeft: Radius.circular(screenSizeInfo.paddingLarge),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SocialInfoWidget(
                        title: currentProfile.socialInfo.followers.toString(),
                        subtitle: "followers",
                      ),
                      SocialInfoWidget(
                        title: currentProfile.socialInfo.posts.toString(),
                        subtitle: "posts",
                      ),
                      SocialInfoWidget(
                        title: currentProfile.socialInfo.following.toString(),
                        subtitle: "following",
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(screenSizeInfo.paddingLarge),
                        topLeft: Radius.circular(screenSizeInfo.paddingLarge),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.8),
                            spreadRadius: 15,
                            blurRadius: 13)
                      ]),
                  height: screenSizeInfo.screenHeight * 0.45,
                  width: screenSizeInfo.screenWidth,
                  padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
                  margin: EdgeInsets.fromLTRB(
                      screenSizeInfo.paddingSmall * 0.25,
                      0,
                      screenSizeInfo.paddingSmall * 0.25,
                      screenSizeInfo.paddingSmall * 0.25),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ProfileWidget(
                            name: currentProfile.name,
                            location: currentProfile.location,
                          ),
                          Spacer(),
                          FollowButtonWidget()
                        ],
                      ),
                      Opacity(
                        opacity: (widget.dragPosition * 3) - 1.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: buildEdgeInsets(screenSizeInfo),
                              child: Text(
                                currentProfile.info,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: screenSizeInfo.textSizeSmall * 1.3,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSizeInfo.paddingLarge * 1.1,
                            ),
                            Padding(
                              padding: buildEdgeInsets(screenSizeInfo),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Photos",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize:
                                          screenSizeInfo.textSizeSmall * 1.5),
                                ),
                              ),
                            ),
                            UserPhotosWidget(currentProfile)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  EdgeInsets buildEdgeInsets(ScreenSizeInfo screenSizeInfo) {
    return EdgeInsets.fromLTRB(screenSizeInfo.paddingSmall * 1.5, 0,
        screenSizeInfo.paddingSmall * 1.5, 0);
  }
}

class UserPhotosWidget extends BaseStatelessWidget {
  final UserProfile userProfile;

  const UserPhotosWidget(
    this.userProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      height: screenSizeInfo.screenHeight * 0.15,
      width: screenSizeInfo.screenWidth,
      padding: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingSmall, screenSizeInfo.paddingSmall, 0, 0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (var image in userProfile.galleryPhotos)
            UserPhotoListItemWidget(imagePath: image),
        ],
      ),
    );
  }
}

class UserPhotoListItemWidget extends BaseStatelessWidget {
  final imagePath;

  const UserPhotoListItemWidget({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          0, screenSizeInfo.paddingMedium, screenSizeInfo.paddingMedium, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 150,
          width: 110,
          color: Colors.redAccent,
          child: FittedBox(
            fit: BoxFit.cover,
            child: CachedNetworkImage(
              imageUrl: imagePath,
            ),
          ),
        ),
      ),
    );
  }
}

class FollowButtonWidget extends StatefulWidget {
  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: OutlineButton(
            onPressed: () {},
            textColor: Colors.red.shade700,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            borderSide: BorderSide(
                color: Colors.red.shade700, style: BorderStyle.solid),
            child: Text(
              "FOLLOW",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final name;
  final location;

  const ProfileWidget({
    Key key,
    @required this.name,
    @required this.location,
  }) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return ShowUpTransitionWidget(
          key: ValueKey(widget.name),
          child: Padding(
            padding: EdgeInsets.all(screenSizeInfo.paddingSmall * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenSizeInfo.textSizeMedium * 1.1,
                  ),
                ),
                Text(
                  widget.location,
                  key: ValueKey(widget.location),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: screenSizeInfo.textSizeSmall * 1.2,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SocialInfoWidget extends BaseStatelessWidget {
  final subtitle;
  final title;

  const SocialInfoWidget(
      {Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return ShowUpTransitionWidget(
      key: ValueKey(title),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            screenSizeInfo.paddingLarge,
            screenSizeInfo.paddingSmall,
            screenSizeInfo.paddingLarge,
            screenSizeInfo.paddingSmall),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: screenSizeInfo.textSizeSmall * 1.5,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              ),
              Text(
                subtitle,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontSize: screenSizeInfo.textSizeSmall * 1.5,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
