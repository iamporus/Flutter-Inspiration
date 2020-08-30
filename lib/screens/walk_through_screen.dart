import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/screens/home_screen.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/widgets/app_logo.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';
import 'package:flutter_design_challenge/widgets/show_up_transition.dart';
import 'package:google_fonts/google_fonts.dart';

class WalkThroughScreen extends StatefulWidget {
  final bool shouldPopOnStart;

  const WalkThroughScreen({
    Key key,
    this.shouldPopOnStart = false,
  }) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final _pageCount = 4;
  int _selectedPageIndex = 0;
  ValueNotifier<double> _notifier = ValueNotifier<double>(0);

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Container(
          height: screenSizeInfo.screenHeight,
          child: Stack(
            children: [
              PageView(
                onPageChanged: _handlePageChanged,
                children: [
                  _WalkThroughPage(
                    backgroundColor: Colors.red.shade700,
                    assetUrl: "assets/app_logo_anim.flr",
                    isAnim: true,
                    titleText: "Flutter Inspiration",
                    descriptionText:
                        "Find Beautiful designs and know how to implement them!\n ",
                  ),
                  _WalkThroughPage(
                    backgroundColor: Colors.blue,
                    assetUrl: "assets/walkthrough_designs.webp",
                    titleText: "Find Designs",
                    descriptionText:
                        "Popular designs from Dribbble brought to life through Flutter code",
                  ),
                  _WalkThroughPage(
                    backgroundColor: Colors.green,
                    assetUrl: "assets/walkthrough_source_code.webp",
                    titleText: "View Source Code",
                    descriptionText:
                        "Check out the Source Code to know how it is implemented",
                  ),
                  _WalkThroughPage(
                    backgroundColor: Colors.orange.shade700,
                    assetUrl: "assets/walkthrough_notifications.webp",
                    titleText: "Get Notified",
                    descriptionText:
                        "Receive notifications when new Designs get added.",
                  ),
                ],
              ),
              Positioned(
                bottom: screenSizeInfo.paddingXLarge * 2.8,
                width: screenSizeInfo.screenWidth,
                child: ShowUpTransition(
                  direction: AxisDirection.up,
                  delayInMilliseconds: 2000,
                  animationDurationInMilliseconds: 750,
                  child: _PageIndicator(
                    pageCount: _pageCount,
                    selectedPageIndex: _selectedPageIndex,
                  ),
                ),
              ),
              Positioned(
                bottom: screenSizeInfo.paddingMedium * 1.5,
                left: screenSizeInfo.paddingMedium,
                right: screenSizeInfo.paddingMedium,
                child: ShowUpTransition(
                  delayInMilliseconds: 2000,
                  animationDurationInMilliseconds: 750,
                  direction: AxisDirection.up,
                  child: _StartButton(
                    onPressed: () {
                      if (widget.shouldPopOnStart) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pop(context);
                        _navigateToHomeScreen(context);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _handlePageChanged(int value) {
    _selectedPageIndex = value;
    setState(() {});
  }

  void _navigateToHomeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HomeScreen(
            isFirstTime: true,
          );
        },
        settings: RouteSettings(name: "HomeScreen"),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    Key key,
    @required int pageCount,
    @required int selectedPageIndex,
  })  : _pageCount = pageCount,
        _selectedPageIndex = selectedPageIndex,
        super(key: key);

  final int _pageCount;
  final int _selectedPageIndex;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < _pageCount; i++)
              _LineIndicator(indicatorState: LineIndicatorState.GRAY),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < _pageCount; i++)
              if (i <= _selectedPageIndex)
                _LineIndicator(indicatorState: LineIndicatorState.WHITE)
              else
                _LineIndicator(indicatorState: LineIndicatorState.TRANSPARENT)
          ],
        ),
      ],
    );
  }
}

class _StartButton extends BaseStatelessWidget {
  final VoidCallback onPressed;

  const _StartButton({
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return RaisedButton(
      color: Colors.white,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(screenSizeInfo.paddingMedium),
      )),
      child: Padding(
        padding: EdgeInsets.all(screenSizeInfo.paddingSmall * 1.8),
        child: Text(
          "Start",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: Colors.blue,
              fontSize: screenSizeInfo.textSizeMedium * 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _WalkThroughPage extends StatefulWidget {
  final Color backgroundColor;
  final String assetUrl;
  final String titleText;
  final bool isAnim;
  final String descriptionText;

  const _WalkThroughPage(
      {Key key,
      @required this.backgroundColor,
      @required this.assetUrl,
      @required this.titleText,
      this.isAnim = false,
      @required this.descriptionText})
      : super(key: key);

  @override
  _WalkThroughPageState createState() => _WalkThroughPageState();
}

class _WalkThroughPageState extends State<_WalkThroughPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    final Animation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _scaleAnimation = Tween(begin: 0.0, end: 0.4).animate(curve);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Material(
        color: widget.backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: screenSizeInfo.paddingXLarge,
            ),
            ShowUpTransition(
              delayInMilliseconds: 500,
              animationDurationInMilliseconds: 750,
              direction: AxisDirection.down,
              child: SizedBox(
                  height: screenSizeInfo.screenHeight * _scaleAnimation.value,
                  width: screenSizeInfo.screenHeight * 0.4,
                  child: widget.isAnim
                      ? FlareActor(
                          widget.assetUrl,
                          animation: AppLogoAnim.SPINNING.toAnimName(),
                        )
                      : Image.asset(widget.assetUrl)),
            ),
            SizedBox(
              height: screenSizeInfo.paddingXLarge * 1.2,
            ),
            ShowUpTransition(
              delayInMilliseconds: 750,
              animationDurationInMilliseconds: 750,
              direction: AxisDirection.up,
              child: Text(
                widget.titleText,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: screenSizeInfo.textSizeLarge,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSizeInfo.paddingLarge,
            ),
            ShowUpTransition(
              delayInMilliseconds: 1000,
              animationDurationInMilliseconds: 750,
              direction: AxisDirection.up,
              child: Padding(
                padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
                child: Text(
                  widget.descriptionText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                      color: Colors.white,
                      height: 1.4,
                      fontSize: screenSizeInfo.textSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

enum LineIndicatorState { TRANSPARENT, WHITE, GRAY }

class _LineIndicator extends BaseStatelessWidget {
  final LineIndicatorState indicatorState;

  const _LineIndicator({
    Key key,
    @required this.indicatorState,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    var lineWidth = (screenSizeInfo.screenWidth / 6);
    var color = _getIndicatorColor(indicatorState);
    return Opacity(
      opacity: _getIndicatorOpacity(indicatorState),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 750),
        foregroundDecoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(
              screenSizeInfo.paddingMedium,
            ),
          ),
        ),
        width: lineWidth,
        height: screenSizeInfo.textSizeSmall * 0.5,
      ),
    );
  }

  Color _getIndicatorColor(indicatorState) {
    switch (indicatorState) {
      case LineIndicatorState.TRANSPARENT:
        return Colors.transparent;
      case LineIndicatorState.WHITE:
        return Colors.white;
      case LineIndicatorState.GRAY:
        return Colors.grey.shade700;
      default:
        return Colors.transparent;
    }
  }

  double _getIndicatorOpacity(LineIndicatorState indicatorState) {
    switch (indicatorState) {
      case LineIndicatorState.TRANSPARENT:
        return 0.0;
      case LineIndicatorState.WHITE:
        return 1.0;
      case LineIndicatorState.GRAY:
        return 0.35;
      default:
        return 0.0;
    }
  }
}
