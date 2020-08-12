import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/models/DesignChangeModel.dart';
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

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
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
            updateBackground(previousDesignIndex, currentDesignIndex);

            return AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: screenSizeInfo.screenWidth,
              height: screenSizeInfo.screenHeight,
              color: _backgroundTweenSequence
                  .evaluate(AlwaysStoppedAnimation(_animationController.value)),
            );
          },
        );
      },
    );
  }

  void updateBackground(int previousDesignIndex, int currentDesignIndex) {
    var beginColor =
        DesignListing.getAvailableDesigns()[previousDesignIndex].paletteColor;
    var endColor =
        DesignListing.getAvailableDesigns()[currentDesignIndex].paletteColor;

    _backgroundTweenSequence =
        _getBackgroundTweenSequence(beginColor, endColor);
    _animationController.forward();
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
