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
  final bool isSettingsOpen;

  DesignListScreen({Key key, this.isSettingsOpen}) : super(key: key);

  @override
  _DesignListScreenState createState() => _DesignListScreenState();
}

class _DesignListScreenState extends State<DesignListScreen>
    with TickerProviderStateMixin {
  AnimationController _colorAnimController;
  AnimationController _carouselAnimController;
  FixedExtentScrollController _designInfoScrollController =
      FixedExtentScrollController();
  FixedExtentScrollController _designScrollController =
      FixedExtentScrollController();
  Design _previousDesign = DesignListing.getAvailableDesigns()[0];
  Design _currentDesign = DesignListing.getAvailableDesigns()[0];
  Animation<Color> _backgroundColorAnimation;
  Animation<double> _carouselHeightAnimation;
  Animation<double> _carouselSqueezeAnimation;
  Animation<double> _carouselOffAxisFractionAnimation;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Flutter Inspiration',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
  );

  @override
  void didUpdateWidget(DesignListScreen oldWidget) {
    if (widget.isSettingsOpen) {
      _carouselAnimController.reverse();
    } else {
      _carouselAnimController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _setupColorAnimation();

    _setupCarouselAnimation();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _designScrollController
          .animateTo(
            150.0,
            duration: Duration(milliseconds: 1750),
            curve: Curves.easeIn,
          )
          .then((value) => _carouselAnimController.forward());
    });
    _initPackageInfo();
    super.initState();
  }

  void _setupCarouselAnimation() {
    _carouselAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _carouselHeightAnimation =
        Tween(begin: 0.31, end: 0.62).animate(_carouselAnimController);

    _carouselSqueezeAnimation =
        Tween(begin: 1.5, end: 1.0).animate(_carouselAnimController);

    _carouselOffAxisFractionAnimation =
        Tween(begin: 0.4, end: 0.0).animate(_carouselAnimController);

    _carouselAnimController.addListener(() {
      setState(() {});
    });
  }

  void _setupColorAnimation() {
    _colorAnimController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    )..addListener(() {
        setState(() {});
      });

    _setupColorTween(_previousDesign.paletteColor, _currentDesign.paletteColor);
  }

  void _setupColorTween(_beginColor, _endColor) {
    _backgroundColorAnimation = ColorTween(
      begin: _beginColor,
      end: _endColor,
    ).animate(_colorAnimController);
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      if (info.appName != null && info.version != null) _packageInfo = info;
    });
  }

  @override
  void dispose() {
    _colorAnimController.dispose();
    _carouselAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return SafeArea(
          child: Material(
            child: Container(
              color: _backgroundColorAnimation.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                    visible: !widget.isSettingsOpen,
                    child: DesignListAppBarWidget(
                      appBarTitle: _packageInfo.appName,
                    ),
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
      height: screenSizeInfo.screenHeight * _carouselHeightAnimation.value,
      width: screenSizeInfo.screenWidth,
      child: HorizontalListWheelScrollView(
        itemExtent: screenSizeInfo.screenHeight * 0.49,
        scrollDirection: Axis.horizontal,
        scrollPhysics: FixedExtentScrollPhysics(),
        squeeze: _carouselSqueezeAnimation.value,
        offAxisFraction: _carouselOffAxisFractionAnimation.value,
        diameterRatio: 2.0,
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

      _setupColorTween(
          _previousDesign.paletteColor, _currentDesign.paletteColor);

      _colorAnimController.reset();
      _colorAnimController.forward();
    });
  }
}
