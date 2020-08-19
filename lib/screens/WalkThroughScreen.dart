import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class WalkThroughScreen extends StatefulWidget {
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
                  WalkThroughPage(
                    backgroundColor: Colors.orange,
                  ),
                  WalkThroughPage(
                    backgroundColor: Colors.green,
                  ),
                  WalkThroughPage(
                    backgroundColor: Colors.pink,
                  ),
                  WalkThroughPage(
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              Positioned(
                  bottom: screenSizeInfo.paddingXLarge * 2,
                  width: screenSizeInfo.screenWidth,
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < _pageCount; i++)
                            LineIndicatorWidget(
                                indicatorState: LineIndicatorState.GRAY),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < _pageCount; i++)
                            if (i <= _selectedPageIndex)
                              LineIndicatorWidget(
                                  indicatorState: LineIndicatorState.WHITE)
                            else
                              LineIndicatorWidget(
                                  indicatorState:
                                      LineIndicatorState.TRANSPARENT)
                        ],
                      ),
                    ],
                  ))
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
}

class WalkThroughPage extends StatefulWidget {
  final Color backgroundColor;

  const WalkThroughPage({
    Key key,
    @required this.backgroundColor,
  }) : super(key: key);

  @override
  _WalkThroughPageState createState() => _WalkThroughPageState();
}

class _WalkThroughPageState extends State<WalkThroughPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _scaleAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    final Animation curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
    _scaleAnimation = Tween(begin: 0.1, end: 0.4).animate(_animationController);
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);

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
              height: screenSizeInfo.textSizeMedium,
            ),
            Opacity(
              opacity: _opacityAnimation.value,
              child: SizedBox(
                  height: screenSizeInfo.screenHeight * _scaleAnimation.value,
                  width: screenSizeInfo.screenHeight * 0.4,
                  child: Image.asset("assets/plant_1.png")),
            ),
            SizedBox(
              height: screenSizeInfo.textSizeXLarge,
            ),
            Text(
              "Find Designs",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: screenSizeInfo.textSizeLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: screenSizeInfo.textSizeMedium,
            ),
            Text(
              "Find popular designs from Dribbble \nbrought to life through Flutter",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: screenSizeInfo.textSizeMedium,
                  fontWeight: FontWeight.bold,
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

class LineIndicatorWidget extends BaseStatelessWidget {
  final LineIndicatorState indicatorState;

  const LineIndicatorWidget({
    Key key,
    @required this.indicatorState,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    var lineWidth = (screenSizeInfo.screenWidth / 6);
    var color = _getIndicatorColor(indicatorState);
    return AnimatedContainer(
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
      height: screenSizeInfo.textSizeSmall * 0.8,
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
}
