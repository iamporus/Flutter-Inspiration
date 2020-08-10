import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignInfoWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignWidget.dart';
import 'package:flutter_design_challenge/widgets/HorizontalListViewScrollView.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignListScreen extends StatefulWidget {
  @override
  _DesignListScreenState createState() => _DesignListScreenState();
}

class _DesignListScreenState extends State<DesignListScreen>
    with TickerProviderStateMixin {
  AnimationController _animController;
  FixedExtentScrollController _designInfoScrollController =
      FixedExtentScrollController();
  Design _previousDesign = DesignListing.getAvailableDesigns()[0];
  Design _currentDesign = DesignListing.getAvailableDesigns()[0];
  TweenSequence<Color> _backgroundTweenSequence;

  @override
  void initState() {
    _animController = AnimationController(
      reverseDuration: const Duration(seconds: 3),
      duration: const Duration(
        seconds: 3,
      ),
      vsync: this,
    );
    _backgroundTweenSequence = _getBackgroundTweenSequence();
    super.initState();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Scaffold(
          backgroundColor: _backgroundTweenSequence
              .evaluate(AlwaysStoppedAnimation(_animController.value)),
          appBar: _buildAppBar(screenSizeInfo),
          body: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    height: screenSizeInfo.screenHeight * 0.62,
                    width: screenSizeInfo.screenWidth,
                    child: HorizontalListWheelScrollView(
                      itemExtent: screenSizeInfo.screenHeight * 0.49,
                      scrollDirection: Axis.horizontal,
                      scrollPhysics: FixedExtentScrollPhysics(),
                      squeeze: 1.2,
                      diameterRatio: 1.75,
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
                  ),
                  Row(
                    children: <Widget>[
                      RawChip(
                        onPressed: () {},
                        labelPadding:
                            EdgeInsets.all(screenSizeInfo.paddingSmall * 0.5),
                        deleteIcon: Icon(Icons.code,
                            color: _currentDesign.paletteColor),
                        elevation: 15,
                        pressElevation: 10,
                        onDeleted: () {},
                        deleteButtonTooltipMessage: "View Source",
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.zero,
                        )),
                        label: Text(
                          "View Source",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              color: _currentDesign.paletteColor,
                              fontSize: screenSizeInfo.textSizeMedium * 0.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      ActionChip(
                        labelPadding:
                            EdgeInsets.all(screenSizeInfo.paddingSmall * 0.5),
                        onPressed: () {},
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.zero,
                            bottomRight: Radius.zero,
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        label: Text(
                          "Favourite",
                          style: GoogleFonts.quicksand(
                            textStyle: TextStyle(
                              color: _currentDesign.paletteColor,
                              fontSize: screenSizeInfo.textSizeMedium * 0.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        avatar: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            _currentDesign.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.pink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: screenSizeInfo.screenHeight * 0.12,
                    color: Colors.transparent,
                    child: HorizontalListWheelScrollView(
                      itemExtent: screenSizeInfo.screenHeight * 0.55,
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
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(ScreenSizeInfo screenSizeInfo) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: Center(
        child: Padding(
          padding: EdgeInsets.all(screenSizeInfo.paddingMedium * 1.5),
          child: Text(
            "Flutter Design Gallery",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                  fontSize: screenSizeInfo.textSizeMedium * 1.4,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 3.0)]),
            ),
          ),
        ),
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
      _backgroundTweenSequence = _getBackgroundTweenSequence();
    });
  }

  TweenSequence<Color> _getBackgroundTweenSequence() {
    return TweenSequence<Color>([
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: _currentDesign.paletteColor.withOpacity(0.9),
          end: _previousDesign.paletteColor.withOpacity(0.9),
        ),
      ),
    ]);
  }
}
