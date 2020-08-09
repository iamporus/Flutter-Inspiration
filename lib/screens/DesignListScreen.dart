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
  FixedExtentScrollController _designScrollController =
      FixedExtentScrollController();
  FixedExtentScrollController _designInfoScrollController =
      FixedExtentScrollController();
  Design _previousDesign = DesignListing.getAvailableDesigns()[0];
  Design _currentDesign = DesignListing.getAvailableDesigns()[0];
  TweenSequence<Color> _backgroundTweenSequence;

  @override
  void initState() {
    _animController = AnimationController(
      duration: const Duration(
        milliseconds: 500,
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
        return AnimatedBuilder(
          animation: _animController,
          builder: (context, child) {
            return Scaffold(
                body: Scaffold(
              backgroundColor: _backgroundTweenSequence.evaluate(
                AlwaysStoppedAnimation(_animController.value),
              ),
              appBar: _buildAppBar(screenSizeInfo),
              body: Column(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      color: Colors.transparent,
                      width: screenSizeInfo.screenWidth,
                      child: HorizontalListWheelScrollView(
                        itemExtent: screenSizeInfo.screenHeight * 0.65,
                        scrollDirection: Axis.horizontal,
                        controller: _designScrollController,
                        squeeze: 1.3,
                        diameterRatio: 3,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return _currentDesign.route;
                            },
                          ));
                        },
                        onSelectedItemChanged: _onDesignItemChanged,
                        builder: (context, index) {
                          var design =
                              DesignListing.getAvailableDesigns()[index];
                          return DesignWidget(design: design);
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: screenSizeInfo.screenHeight * 0.15,
                    child: HorizontalListWheelScrollView(
                      itemExtent: screenSizeInfo.screenHeight * 0.5,
                      scrollDirection: Axis.horizontal,
                      squeeze: 1.3,
                      diameterRatio: 20,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return _currentDesign.route;
                          },
                        ));
                      },
                      onSelectedItemChanged: _onDesignInfoItemChanged,
                      controller: _designInfoScrollController,
                      builder: (context, index) {
                        var design = DesignListing.getAvailableDesigns()[index];
                        return DesignInfoWidget(design: design);
                      },
                    ),
                  ),
                ],
              ),
            ));
          },
        );
      },
    );
  }

  PreferredSize _buildAppBar(ScreenSizeInfo screenSizeInfo) {
    return PreferredSize(
      preferredSize: Size.fromHeight(screenSizeInfo.screenHeight * 0.1),
      child: AppBar(
        elevation: 1.0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Padding(
            padding: EdgeInsets.all(screenSizeInfo.paddingMedium * 1.2),
            child: Text(
              "Flutter Design Gallery",
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  fontSize: screenSizeInfo.textSizeMedium * 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDesignItemChanged(int page) {
    _designInfoScrollController.animateToItem(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    _onItemChanged(page);
  }

  void _onDesignInfoItemChanged(int info) {
    _designScrollController.animateToItem(
      info,
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    _onItemChanged(info);
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
          begin: _previousDesign.paletteColor.withOpacity(0.9),
          end: _currentDesign.paletteColor.withOpacity(0.9),
        ),
      ),
    ]);
  }
}
