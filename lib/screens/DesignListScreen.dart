import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/models/DesignChangeModel.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignInfoWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignListAppBarWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignWidget.dart';
import 'package:flutter_design_challenge/widgets/FavouriteChipWidget.dart';
import 'package:flutter_design_challenge/widgets/HorizontalListViewScrollView.dart';
import 'package:flutter_design_challenge/widgets/ViewSourceChipWidget.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class DesignListScreen extends StatefulWidget {
  @override
  _DesignListScreenState createState() => _DesignListScreenState();
}

class _DesignListScreenState extends State<DesignListScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  FixedExtentScrollController _designInfoScrollController =
      FixedExtentScrollController();
  FixedExtentScrollController _designScrollController =
      FixedExtentScrollController();
  Design _previousDesign = DesignListing.getAvailableDesigns()[0];
  Design _currentDesign = DesignListing.getAvailableDesigns()[0];
  TweenSequence<Color> _backgroundTweenSequence;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    Color _beginColor = _previousDesign.paletteColor;
    Color _endColor = _currentDesign.paletteColor;

    _backgroundTweenSequence =
        _getBackgroundTweenSequence(_beginColor, _endColor);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _designScrollController.animateTo(
        100.0,
        duration: Duration(seconds: 2),
        curve: Curves.easeInCubic,
      );
    });
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
      printLogs: true,
      builder: (context, screenSizeInfo) {
        return SafeArea(
          child: Material(
            child: AnimatedContainer(
              color: _backgroundTweenSequence
                  .evaluate(AlwaysStoppedAnimation(_animationController.value)),
              duration: Duration(milliseconds: 750),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DesignListAppBarWidget(
                    appBarTitle: _packageInfo.appName,
                  ),
                  _buildDesignCarousel(screenSizeInfo, context),
                  Row(
                    children: <Widget>[
                      ViewSourceChipWidget(currentDesign: _currentDesign),
                      Spacer(),
                      FavouriteChipWidget(
                          key: ValueKey(_currentDesign.id),
                          currentDesign: _currentDesign),
                    ],
                  ),
                  _buildDesignInfoCarousel(screenSizeInfo),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container _buildDesignCarousel(
      ScreenSizeInfo screenSizeInfo, BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: screenSizeInfo.screenHeight * 0.62,
      width: screenSizeInfo.screenWidth,
      child: HorizontalListWheelScrollView(
        itemExtent: screenSizeInfo.screenHeight * 0.49,
        scrollDirection: Axis.horizontal,
        scrollPhysics: FixedExtentScrollPhysics(),
        squeeze: 1.2,
        diameterRatio: 1.7,
        controller: _designScrollController,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return _currentDesign.route;
            },
          ));
        },
        onSelectedItemChanged: _onDesignItemChanged,
        builder: (context, index) {
          var design = DesignListing.getAvailableDesigns()[index];
          return DesignWidget(design: design);
        },
      ),
    );
  }

  Container _buildDesignInfoCarousel(ScreenSizeInfo screenSizeInfo) {
    return Container(
      height: screenSizeInfo.screenHeight * 0.12,
      color: Colors.transparent,
      child: HorizontalListWheelScrollView(
        itemExtent: screenSizeInfo.screenHeight * 0.65,
        scrollDirection: Axis.horizontal,
        squeeze: 1.3,
        scrollPhysics: NeverScrollableScrollPhysics(),
        diameterRatio: 15,
        controller: _designInfoScrollController,
        builder: (context, index) {
          var design = DesignListing.getAvailableDesigns()[index];
          return DesignInfoWidget(design: design);
        },
      ),
    );
  }

  void _onDesignItemChanged(int page) {
    _designInfoScrollController.animateToItem(
      page,
      duration: Duration(milliseconds: 600),
      curve: Curves.linear,
    );
    _onItemChanged(page);
  }

  void _onItemChanged(int info) {
    setState(() {
      _previousDesign = _currentDesign;
      _currentDesign = DesignListing.getAvailableDesigns()[info];

      var designChangeModel =
          Provider.of<DesignChangeModel>(context, listen: false);
      designChangeModel.currentDesignValue = info;
      designChangeModel.previousDesignValue = info == 0 ? 0 : info - 1;

      Color _beginColor = _previousDesign.paletteColor;
      Color _endColor = _currentDesign.paletteColor;

      _backgroundTweenSequence =
          _getBackgroundTweenSequence(_beginColor, _endColor);
    });
  }

  TweenSequence<Color> _getBackgroundTweenSequence(
      Color beginColor, Color endColor) {
    return TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: beginColor,
          end: endColor,
        ),
      ),
    ]);
  }
}
