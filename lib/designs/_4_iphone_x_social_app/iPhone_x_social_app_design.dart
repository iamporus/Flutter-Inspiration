import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_4_iphone_x_social_app/current_page_model.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';
import 'package:flutter_design_challenge/widgets/show_up_transition.dart';
import 'package:provider/provider.dart';

import 'user_profile.dart';

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
        create: (_) => CurrentPageModel(),
        child: Stack(
          children: <Widget>[
            _PicturePageView(
              userProfiles: userProfiles,
              dragPosition: position,
            ),
            _ProfileAppBar(),
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
                      behavior: _GlowLessScrollBehavior(),
                      child: DraggableScrollableSheet(
                        initialChildSize: 0.40,
                        minChildSize: 0.40,
                        maxChildSize: 0.68,
                        expand: true,
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            physics: new ClampingScrollPhysics(),
                            child: ProfileDraggableCard(
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
              child: _ProfileBottomAppBar(),
            )
          ],
        ),
      ));
    });
  }
}

class _ProfileAppBar extends BaseStatelessWidget {
  const _ProfileAppBar({
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

class _ProfileBottomAppBar extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(screenSizeInfo.paddingMedium * 1.5),
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

class _PicturePageView extends StatefulWidget {
  final double dragPosition;
  final List<UserProfile> userProfiles;

  const _PicturePageView({
    Key key,
    @required this.userProfiles,
    @required this.dragPosition,
  }) : super(key: key);

  @override
  _PicturePageViewState createState() => _PicturePageViewState();
}

class _PicturePageViewState extends State<_PicturePageView> {
  PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pageController.addListener(_handlePageChange);
    super.initState();
  }

  void _handlePageChange() {
    final profileModal = Provider.of<CurrentPageModel>(context, listen: false);
    setState(() {
      _selectedPageIndex = _pageController.page.toInt();
      profileModal.currentPageValue = _selectedPageIndex;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Container(
        height:
        (screenSizeInfo.screenHeight * 0.85) * (0.40 / widget.dragPosition),
        width: screenSizeInfo.screenWidth,
        child: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (var profile in widget.userProfiles)
              _ProfilePage(profilePictureImage: profile.profileImage),
          ],
        ),
      );
    });
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({
    Key key,
    @required this.profilePictureImage,
  }) : super(key: key);

  final profilePictureImage;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Align(
        alignment: Alignment.center,
        child: CachedNetworkImage(
          imageUrl: profilePictureImage,
        ),
      ),
    );
  }
}

class ProfileDraggableCard extends StatefulWidget {
  final double dragPosition;
  final List<UserProfile> userProfiles;

  const ProfileDraggableCard({
    Key key,
    @required this.dragPosition,
    @required this.userProfiles,
  }) : super(key: key);

  @override
  _ProfileDraggableCardState createState() =>
      _ProfileDraggableCardState();
}

class _ProfileDraggableCardState
    extends State<ProfileDraggableCard> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Consumer<CurrentPageModel>(
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
                      _SocialInfoWidget(
                        title: currentProfile.socialInfo.followers.toString(),
                        subtitle: "followers",
                      ),
                      _SocialInfoWidget(
                        title: currentProfile.socialInfo.posts.toString(),
                        subtitle: "posts",
                      ),
                      _SocialInfoWidget(
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
                            color: Colors.black.withOpacity(0.6),
                            spreadRadius: 13,
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
                          Padding(
                            padding: EdgeInsets.all(
                                screenSizeInfo.paddingSmall * 1.5),
                            child: ShowUpTransition(
                              key: ValueKey(currentProfile.name),
                              child: FollowButtonWidget(
                                key: ValueKey(currentProfile.name),
                                animationDuration: Duration(milliseconds: 400),
                              ),
                            ),
                          )
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
                            _UserPhotosWidget(currentProfile)
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

class _UserPhotosWidget extends BaseStatelessWidget {
  final UserProfile userProfile;

  const _UserPhotosWidget(
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
            _UserPhotoListItemWidget(imagePath: image),
        ],
      ),
    );
  }
}

class _UserPhotoListItemWidget extends BaseStatelessWidget {
  final imagePath;

  const _UserPhotoListItemWidget({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: screenSizeInfo.screenHeight * 0.16,
          width: screenSizeInfo.screenWidth * 0.30,
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
        return ShowUpTransition(
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

class _SocialInfoWidget extends BaseStatelessWidget {
  final subtitle;
  final title;

  const _SocialInfoWidget(
      {Key key, @required this.title, @required this.subtitle})
      : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return ShowUpTransition(
      key: ValueKey(title),
      child: Padding(
        padding: EdgeInsets.fromLTRB(screenSizeInfo.paddingLarge,
            screenSizeInfo.paddingSmall, screenSizeInfo.paddingMedium, 0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: screenSizeInfo.textSizeSmall * 1.4,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FollowButtonWidget extends StatefulWidget {
  final Duration animationDuration;
  final VoidCallback onTap;

  FollowButtonWidget({Key key, this.animationDuration, this.onTap})
      : super(key: key);

  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  static double _initialButtonWidth;
  static double _finalButtonWidth;
  static Color _initialBorderColor = Colors.red.shade700;
  static Color _finalBorderColor = Colors.white;
  Color _borderColor = _initialBorderColor;
  Color _color = _finalBorderColor;
  double _width = 0.0;
  ButtonState _buttonState = ButtonState.SHOW_TEXT;

  @override
  void didChangeDependencies() {
    _initialButtonWidth = MediaQuery.of(context).size.width * 0.30;
    _finalButtonWidth = MediaQuery.of(context).size.width * 0.13;
    _width = _initialButtonWidth;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      double buttonHeight = screenSizeInfo.screenHeight * 0.06;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _changeState,
          child: AnimatedContainer(
            height: buttonHeight,
            width: _width,
            duration: widget.animationDuration,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: _borderColor)),
            child: _buttonState == ButtonState.SHOW_ICON
                ? Icon(
              Icons.person_outline,
              color: Colors.white,
            )
                : Center(
              child: Text(
                "FOLLOW",
                style: TextStyle(
                    wordSpacing: 1.1,
                    fontWeight: FontWeight.bold,
                    color: _initialBorderColor,
                    fontSize: screenSizeInfo.textSizeSmall * 1.5),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _changeState() {
    setState(() {
      _width = (_width == _initialButtonWidth)
          ? _finalButtonWidth
          : _initialButtonWidth;
      _borderColor = (_borderColor == _initialBorderColor)
          ? _finalBorderColor
          : _initialBorderColor;
      _color = (_color == _initialBorderColor)
          ? _finalBorderColor
          : _initialBorderColor;
      _buttonState = (_buttonState == ButtonState.SHOW_TEXT)
          ? ButtonState.SHOW_ICON
          : ButtonState.SHOW_TEXT;
    });
  }
}

enum ButtonState { SHOW_TEXT, SHOW_ICON }

class _GlowLessScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
