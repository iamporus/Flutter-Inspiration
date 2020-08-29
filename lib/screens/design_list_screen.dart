import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/design_listing.dart';
import 'package:flutter_design_challenge/models/design.dart';
import 'package:flutter_design_challenge/models/design_change_model.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/utils/scale_route.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';
import 'package:flutter_design_challenge/widgets/design_info.dart';
import 'package:flutter_design_challenge/widgets/design_list_app_bar.dart';
import 'package:flutter_design_challenge/widgets/design_card.dart';
import 'package:flutter_design_challenge/widgets/favourite_chip.dart';
import 'package:flutter_design_challenge/widgets/horizontal_listView_scrollView.dart';
import 'package:flutter_design_challenge/widgets/view_source_chip.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

class DesignListScreen extends StatefulWidget {
  final bool isSettingsOpen;
  final bool isFirstTime;

  DesignListScreen({
    Key key,
    this.isSettingsOpen = false,
    this.isFirstTime,
  }) : super(key: key);

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
  GlobalKey _showcaseDesignRotateKey = GlobalKey();
  GlobalKey _showcaseDesignDetailsKey = GlobalKey();
  GlobalKey _showcaseDesignInfoKey = GlobalKey();
  GlobalKey _showcaseViewSourceKey = GlobalKey();
  GlobalKey _showcaseMarkFavKey = GlobalKey();
  bool _isFirstTime;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Flutter Inspiration',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
  );

  @override
  void didUpdateWidget(DesignListScreen oldWidget) {
    if (!_isFirstTime) {
      widget.isSettingsOpen
          ? _carouselAnimController.reverse()
          : _carouselAnimController.forward();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _setupColorAnimation();
    _setupCarouselAnimation();
    _isFirstTime = widget.isFirstTime;

    if (_isFirstTime) {
      _setupShowCase();
    } else {
      _carouselAnimController.forward();
    }
    _initPackageInfo();
    super.initState();
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
                    child: DesignListAppBar(
                      appBarTitle: _packageInfo.appName,
                    ),
                  ),
                  _isFirstTime
                      ? _buildCarouselWithShowcase(context, screenSizeInfo)
                      : _buildDesignCarousel(screenSizeInfo, context),
                  Row(
                    children: <Widget>[
                      _isFirstTime
                          ? _buildViewSourceWithShowcase()
                          : _buildViewSourceChipWidget(),
                      Spacer(),
                      _isFirstTime
                          ? _buildFavoriteChipWithShowcase()
                          : _buildFavouriteChipWidget()
                    ],
                  ),
                  _isFirstTime
                      ? _buildInfoCarouselWithShowcase(context, screenSizeInfo)
                      : _buildDesignInfoCarousel()
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Showcase _buildFavoriteChipWithShowcase() {
    return Showcase(
      key: _showcaseMarkFavKey,
      description: "Mark the Design as Favorite",
      child: _buildFavouriteChipWidget(),
    );
  }

  FavouriteChip _buildFavouriteChipWidget() {
    return FavouriteChip(
      key: ValueKey(_currentDesign.id),
      currentDesign: _currentDesign,
    );
  }

  Showcase _buildViewSourceWithShowcase() {
    return Showcase(
        key: _showcaseViewSourceKey,
        description: "Check out the Source Code for selected Design",
        child: _buildViewSourceChipWidget());
  }

  ViewSourceChip _buildViewSourceChipWidget() =>
      ViewSourceChip(currentDesign: _currentDesign);

  Showcase _buildCarouselWithShowcase(
      BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Showcase(
        onTargetClick: () {
          _carouselAnimController.forward().then((value) => setState(() {
                ShowCaseWidget.of(context).startShowCase([
                  _showcaseDesignDetailsKey,
                  _showcaseViewSourceKey,
                  _showcaseMarkFavKey,
                  _showcaseDesignInfoKey
                ]);
              }));
        },
        disposeOnTap: true,
        key: _showcaseDesignRotateKey,
        description: "Rotate to see the Designs",
        child: Showcase(
          key: _showcaseDesignDetailsKey,
          description: "Tap on the Design to see it live in action.",
          child: _buildDesignCarousel(screenSizeInfo, context),
        ));
  }

  Widget _buildDesignCarousel(
      ScreenSizeInfo screenSizeInfo, BuildContext context) {
    return _DesignCarousel(
        carouselHeightAnimation: _carouselHeightAnimation,
        carouselSqueezeAnimation: _carouselSqueezeAnimation,
        carouselOffAxisFractionAnimation: _carouselOffAxisFractionAnimation,
        designScrollController: _designScrollController,
        currentDesign: _currentDesign,
        onDesignChanged: _onDesignItemChanged);
  }

  _buildInfoCarouselWithShowcase(
      BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Showcase(
      key: _showcaseDesignInfoKey,
      child: _buildDesignInfoCarousel(),
      description: "Tap to see the source Design on Dribbble.",
      onTargetClick: () {
        _isFirstTime = false;
        dissolveFirstTimeState();
      },
      disposeOnTap: true,
    );
  }

  _buildDesignInfoCarousel() => _DesignInfoCarousel(
      currentDesign: _currentDesign,
      designInfoScrollController: _designInfoScrollController);

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
        _previousDesign.paletteColor,
        _currentDesign.paletteColor,
      );

      _colorAnimController.reset();
      _colorAnimController.forward();
    });
  }

  void _setupShowCase() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShowCaseWidget.of(context).startShowCase([
        _showcaseDesignRotateKey,
      ]);
      _designScrollController
          .animateTo(
            150.0,
            duration: Duration(milliseconds: 1750),
            curve: Curves.easeIn,
          )
          .then((value) => _designScrollController.animateTo(
                -150.0,
                duration: Duration(milliseconds: 1750),
                curve: Curves.easeIn,
              ));
    });
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
}

class _DesignCarousel extends BaseStatelessWidget {
  const _DesignCarousel({
    Key key,
    @required Animation<double> carouselHeightAnimation,
    @required Animation<double> carouselSqueezeAnimation,
    @required Animation<double> carouselOffAxisFractionAnimation,
    @required FixedExtentScrollController designScrollController,
    @required Design currentDesign,
    @required Function onDesignChanged,
  })  : _carouselHeightAnimation = carouselHeightAnimation,
        _carouselSqueezeAnimation = carouselSqueezeAnimation,
        _carouselOffAxisFractionAnimation = carouselOffAxisFractionAnimation,
        _designScrollController = designScrollController,
        _currentDesign = currentDesign,
        _onDesignChanged = onDesignChanged,
        super(key: key);

  final Animation<double> _carouselHeightAnimation;
  final Animation<double> _carouselSqueezeAnimation;
  final Animation<double> _carouselOffAxisFractionAnimation;
  final FixedExtentScrollController _designScrollController;
  final Design _currentDesign;
  final void Function(int) _onDesignChanged;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
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
          Navigator.push(
            context,
            ScaleRoute(
              page: _currentDesign.route,
              name: _currentDesign.title,
            ),
          );
        },
        onSelectedItemChanged: _onDesignChanged,
        builder: (context, index) {
          var design = DesignListing.getAvailableDesigns()[index];
          return DesignCard(design: design);
        },
      ),
    );
  }
}

class _DesignInfoCarousel extends BaseStatelessWidget {
  const _DesignInfoCarousel({
    Key key,
    @required Design currentDesign,
    @required FixedExtentScrollController designInfoScrollController,
  })  : _designInfoScrollController = designInfoScrollController,
        _currentDesign = currentDesign,
        super(key: key);

  final FixedExtentScrollController _designInfoScrollController;
  final Design _currentDesign;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: screenSizeInfo.screenHeight * 0.12,
          color: Colors.transparent,
          child: HorizontalListWheelScrollView(
            itemExtent: screenSizeInfo.screenHeight * 0.65,
            scrollDirection: Axis.horizontal,
            squeeze: 1.3,
            scrollPhysics: NeverScrollableScrollPhysics(),
            diameterRatio: 15,
            onTap: () {
              launchURL(context, _currentDesign.link);
            },
            controller: _designInfoScrollController,
            builder: (context, index) {
              var design = DesignListing.getAvailableDesigns()[index];
              return DesignInfo(
                design: design,
              );
            },
          ),
        ),
      ),
    );
  }
}
