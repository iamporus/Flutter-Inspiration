import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/models/DesignChangeModel.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignListAppBarWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

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
  TweenSequence<Color> _backgroundTweenSequence;
  Color _previousBackgroundColor;
  Color _currentBackgroundColor;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _initPackageInfo();
    super.initState();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
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
        return Consumer<DesignChangeModel>(
          builder: (context, designChangeModel, _) {
            var currentDesignIndex = designChangeModel.currentDesignIndex;
            var previousDesignIndex = designChangeModel.previousDesignIndex;
            _updateBackground(previousDesignIndex, currentDesignIndex);

            return Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                padding: EdgeInsets.fromLTRB(
                    screenSizeInfo.paddingSmall,
                    screenSizeInfo.paddingLarge,
                    screenSizeInfo.paddingSmall,
                    0),
                margin:
                    EdgeInsets.only(bottom: screenSizeInfo.screenHeight * 0.1),
                width: screenSizeInfo.screenWidth,
                height: screenSizeInfo.screenHeight,
                color: _backgroundTweenSequence.evaluate(
                    AlwaysStoppedAnimation(_animationController.value)),
                child: Column(
                  children: <Widget>[
                    DesignListAppBarWidget(
                      appBarTitle: "Menu",
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [
                                _previousBackgroundColor ==
                                        _currentBackgroundColor
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant
                                    : _previousBackgroundColor,
                                _currentBackgroundColor,
                              ],
                              transform: GradientRotation(90),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                            ),
                            _AppLogoWidget(),
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                            ),
                            _AppTitleWidget(packageInfo: _packageInfo),
                            Spacer(),
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                            ),
                            _SettingsListItem(
                              title: "Share Feedback",
                              icon: Icons.feedback,
                              onTap: () {},
                            ),
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                              child: Divider(
                                height: 1.0,
                                color: Colors.white70,
                              ),
                            ),
                            _SettingsListItem(
                                title: "Licenses",
                                icon: Icons.filter_frames,
                                onTap: () {
                                  showLicensePage(
                                    context: context,
                                    applicationIcon: Icon(
                                      Icons.whatshot,
                                      color: Colors.red,
                                      size: screenSizeInfo.textSizeXLarge * 1.5,
                                    ),
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
                            _SourceCodeListItem(),
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
                            ),
                            _GithubIconListItem(),
                            SizedBox(
                              height: screenSizeInfo.paddingSmall,
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

    _backgroundTweenSequence = _getBackgroundTweenSequence();
    _animationController.forward();
  }

  TweenSequence<Color> _getBackgroundTweenSequence() {
    return TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: _previousBackgroundColor,
          end: _currentBackgroundColor,
        ),
      ),
    ]);
  }
}

class _AppTitleWidget extends BaseStatelessWidget {
  const _AppTitleWidget({
    Key key,
    @required PackageInfo packageInfo,
  })  : _packageInfo = packageInfo,
        super(key: key);

  final PackageInfo _packageInfo;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return ListTile(
      title: Text(
        _packageInfo.appName,
        style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                fontSize: screenSizeInfo.textSizeLarge,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 3.0)])),
      ),
      subtitle: Text(
        _packageInfo.version,
        style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                fontSize: screenSizeInfo.textSizeMedium,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 3.0)])),
      ),
    );
  }
}

class _AppLogoWidget extends BaseStatelessWidget {
  const _AppLogoWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Center(
      child: CircleAvatar(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Icon(
              Icons.whatshot,
              color: Colors.red,
              size: screenSizeInfo.textSizeXLarge * 1.5,
            ),
          ),
        ),
        radius: screenSizeInfo.paddingXLarge * 1.5,
        backgroundColor: Colors.white.withOpacity(0.1),
      ),
    );
  }
}

class _GithubIconListItem extends BaseStatelessWidget {
  const _GithubIconListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Center(
      child: CircleAvatar(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/github_logo.png",
            ),
          ),
        ),
        radius: screenSizeInfo.paddingLarge,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class _SourceCodeListItem extends BaseStatelessWidget {
  const _SourceCodeListItem({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: Text(
        "Looking for entire Source Code? \nFork it from here:",
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
              fontSize: screenSizeInfo.textSizeMedium,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [Shadow(blurRadius: 3.0)]),
        ),
      ),
    );
  }
}

class _SettingsListItem extends BaseStatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SettingsListItem({
    @required this.title,
    @required this.icon,
    @required this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white70,
          ),
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
