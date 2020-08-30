import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/design_listing.dart';
import 'package:flutter_design_challenge/models/design_change_model.dart';
import 'package:flutter_design_challenge/models/settings_collapse_model.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/utils/analytics_service.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_design_challenge/widgets/app_logo.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import 'walk_through_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> _backgroundColorAnimation;
  PageController _pageController;
  Color _previousBackgroundColor;
  Color _currentBackgroundColor;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Flutter Inspiration',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _initPackageInfo();
    _pageController = PageController();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      if (info.appName != null && info.version != null) _packageInfo = info;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Consumer2<DesignChangeModel, SettingsCollapseModel>(
          builder: (context, designChangeModel, settingsCollapseModel, _) {
            var currentDesignIndex = designChangeModel.currentDesignIndex;
            var previousDesignIndex = designChangeModel.previousDesignIndex;
            _updateBackground(previousDesignIndex, currentDesignIndex);
            if (settingsCollapseModel.isSettingsCollapsed)
              _pageController.animateToPage(0,
                  duration: Duration(milliseconds: 250), curve: Curves.easeIn);

            return Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding:
                    EdgeInsets.fromLTRB(0, screenSizeInfo.paddingLarge, 0, 0),
                margin:
                    EdgeInsets.only(bottom: screenSizeInfo.screenHeight * 0.15),
                width: screenSizeInfo.screenWidth,
                height: screenSizeInfo.screenHeight,
                color: _backgroundColorAnimation.value,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: screenSizeInfo.paddingXLarge * 1.5,
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.dstIn,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25)),
                            gradient: LinearGradient(
                                colors: [
                                  _currentBackgroundColor.withOpacity(0.2),
                                  _currentBackgroundColor.withOpacity(0.8),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                            ),
                            _AppTitleHeader(
                              packageInfo: _packageInfo,
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              child: PageView(
                                controller: _pageController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  _SettingsPage(
                                    packageInfo: _packageInfo,
                                    pageController: _pageController,
                                  ),
                                  _CreditsPage(
                                    onTap: () {
                                      _pageController.animateToPage(0,
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _updateBackground(int previousDesignIndex, int currentDesignIndex) {
    _previousBackgroundColor =
        DesignListing.getAvailableDesigns()[previousDesignIndex].paletteColor;
    _currentBackgroundColor =
        DesignListing.getAvailableDesigns()[currentDesignIndex].paletteColor;

    _backgroundColorAnimation = _getBackgroundColorTween();
    _animationController.forward();
  }

  Animation<Color> _getBackgroundColorTween() {
    return ColorTween(
      begin: _previousBackgroundColor,
      end: _currentBackgroundColor,
    ).animate(_animationController);
  }
}

class _SettingsPage extends BaseStatelessWidget {
  const _SettingsPage({
    Key key,
    @required PackageInfo packageInfo,
    @required PageController pageController,
  })  : _packageInfo = packageInfo,
        _pageController = pageController,
        super(key: key);

  final PackageInfo _packageInfo;
  final PageController _pageController;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: screenSizeInfo.paddingLarge,
        ),
        _SettingsListItem(
            title: "Licenses",
            icon: Icons.filter_frames,
            onTap: () {
              showLicensePage(
                context: context,
                applicationVersion: _packageInfo.version,
                applicationName: _packageInfo.appName,
              );
            }),
        SizedBox(
          height: screenSizeInfo.paddingSmall,
          child: Divider(
            height: 1.0,
            color: Colors.white70,
          ),
        ),
        _SettingsListItem(
            title: "Credits",
            icon: Icons.people,
            onTap: () {
              AnalyticsService().logViewCreditsClicked();
              _pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            }),
        SizedBox(
          height: screenSizeInfo.paddingSmall,
          child: Divider(
            height: 1.0,
            color: Colors.white70,
          ),
        ),
        _SettingsListItem(
          title: "Share Feedback",
          icon: Icons.feedback,
          onTap: () {
            launchURL(context,
                "https://github.com/iamporus/Flutter-Inspiration/issues/new/choose");
          },
        ),
        SizedBox(
          height: screenSizeInfo.paddingSmall,
          child: Divider(
            height: 1.0,
            color: Colors.white70,
          ),
        ),
        _SettingsListItem(
            title: "Show Onboarding Screen",
            icon: Icons.burst_mode,
            onTap: () {
              AnalyticsService().logViewWalkThroughClicked();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return WalkThroughScreen(
                  shouldPopOnStart: true,
                );
              }));
            }),
        SizedBox(
          height: screenSizeInfo.paddingMedium,
          child: Divider(
            height: 1.0,
            color: Colors.white70,
          ),
        ),
        _SettingsListItem(
            title: "Contribute to the App",
            iconWidget: CircleAvatar(
              child: Image.asset(
                "assets/github_logo.png",
              ),
              radius: screenSizeInfo.paddingSmall * 1.3,
              backgroundColor: Colors.white,
            ),
            onTap: () {
              AnalyticsService().logViewRepoClicked();
              launchURL(
                  context, "https://github.com/iamporus/Flutter-Inspiration/");
            }),
        SizedBox(
          height: screenSizeInfo.paddingSmall,
        ),
      ],
    );
  }
}

class _CreditsPage extends BaseStatelessWidget {
  final VoidCallback onTap;

  _CreditsPage({this.onTap});

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return index == 0
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: onTap,
                  ),
                )
              : ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(screenSizeInfo.paddingSmall * 0.5)),
                    child: _Credit.getCredits()[index - 1].isNetworkAsset
                        ? CachedNetworkImage(
                            imageUrl: _Credit.getCredits()[index - 1].imageUrl,
                            width: screenSizeInfo.textSizeLarge,
                            height: screenSizeInfo.textSizeLarge,
                            fit: BoxFit.cover,
                          )
                        : _Credit.getCredits()[index - 1].isSvgAsset
                            ? SvgPicture.asset(
                                _Credit.getCredits()[index - 1].imageUrl,
                                width: screenSizeInfo.textSizeLarge,
                                height: screenSizeInfo.textSizeLarge,
                                fit: BoxFit.cover,
                                color: Colors.white,
                              )
                            : Image.asset(
                                _Credit.getCredits()[index - 1].imageUrl,
                                width: screenSizeInfo.textSizeLarge,
                                height: screenSizeInfo.textSizeLarge,
                                fit: BoxFit.cover,
                              ),
                  ),
                  title: Text(
                    _Credit.getCredits()[index - 1].title,
                    style: TextStyle(color: Colors.white),
                  ),
                );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.white,
        ),
        itemCount: _Credit.getCredits().length + 1,
      ),
    );
  }
}

class _Credit {
  final String title;
  final String imageUrl;
  final bool isNetworkAsset;
  final bool isSvgAsset;

  _Credit({
    this.isNetworkAsset = false,
    this.title,
    this.imageUrl,
    this.isSvgAsset = false,
  });

  static List<_Credit> getCredits() {
    return [
      _Credit(
          title: "iPhoneX Social App Design by Shakuro",
          imageUrl:
              "https://cdn.dribbble.com/users/110372/screenshots/3898209/andrew_morozkin_-_user_profile_2_still_2x.gif?resize=100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Sign In / Sign Up UI Design by Giga Tamarashvili",
          imageUrl:
              "https://cdn.dribbble.com/users/952958/screenshots/6371155/2_4x.png?compress=1&resize=100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Simple Game App Concept Design by Zoltán Czigány",
          imageUrl:
              "https://cdn.dribbble.com/users/4231329/screenshots/13752058/media/c58801393386278c8c36a6f9ab2a9a9b.png?compress=1&resize=100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Plant Shop Design by Julia Jakubiak",
          imageUrl:
              "https://cdn.dribbble.com/users/1558331/screenshots/6158149/6_4x.png?compress=1&resize=100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Mobile App - Chapter Design by Outcrowd",
          imageUrl:
              "https://static.dribbble.com/users/702789/screenshots/11524146/media/e801469b335bd9800168287a0fc48c73.png?compress=1&resize==100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Wishli | Onboarding screen Design by Aryana Shakibaei",
          imageUrl:
              "https://static.dribbble.com/users/142973/screenshots/6496976/wishli_-_onboarding_screen.png?compress=1&resize==100x100",
          isNetworkAsset: true),
      _Credit(
          title: "Eyeglasses Icon made by Smashicons from www.flaticon.com",
          imageUrl: "assets/vision.svg",
          isSvgAsset: true),
      _Credit(
        title: "Ghost of Tsushima Wallpaper by www.playstation.com",
        imageUrl: "assets/ghost.webp",
      ),
      _Credit(
        title: "Plant Images by www.pngtree.com",
        imageUrl: "assets/plant_1.png",
      ),
      _Credit(
        title: "Humaaans by Pablo Stanley",
        imageUrl: "assets/humaaans_1.png",
      ),
      _Credit(
        title: "Dribbble Icon made by Dave Gandy from www.flaticon.com",
        imageUrl: "assets/dribbble_logo.svg",
        isSvgAsset: true
      ),
    ];
  }
}

class _AppTitleHeader extends BaseStatelessWidget {
  const _AppTitleHeader({
    Key key,
    @required PackageInfo packageInfo,
  })  : _packageInfo = packageInfo,
        super(key: key);

  final PackageInfo _packageInfo;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return ListTile(
      leading: Container(
        width: screenSizeInfo.paddingXLarge,
        height: screenSizeInfo.paddingXLarge,
        child: AppLogo(
          radius: screenSizeInfo.paddingXLarge,
          anim: AppLogoAnim.SPINNING,
        ),
      ),
      title: Text(
        _packageInfo.appName,
        style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                fontSize: screenSizeInfo.textSizeLarge,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 3.0)])),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(
          right: screenSizeInfo.paddingLarge,
        ),
        child: Text(
          "v" + _packageInfo.version,
          textAlign: TextAlign.right,
          style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                  fontSize: screenSizeInfo.textSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 3.0)])),
        ),
      ),
    );
  }
}

class _SettingsListItem extends BaseStatelessWidget {
  final String title;
  final IconData icon;
  final Widget iconWidget;
  final VoidCallback onTap;

  const _SettingsListItem({
    @required this.title,
    @required this.onTap,
    this.icon,
    this.iconWidget,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: iconWidget == null
              ? Icon(
                  icon,
                  color: Colors.white,
                  size: screenSizeInfo.textSizeMedium * 1.5,
                )
              : iconWidget,
          title: Text(
            title,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                  fontSize: screenSizeInfo.textSizeMedium,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 3.0)]),
            ),
          ),
        ),
      ),
    );
  }
}
