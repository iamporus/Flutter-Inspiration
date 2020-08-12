import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/models/DesignChangeModel.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  final backgroundColor;

  const SettingsScreen({
    Key key,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Consumer<DesignChangeModel>(
          builder: (context, designChangeModel, _) {
            var design = designChangeModel.currentDesignIndex;
            return Container(
              width: screenSizeInfo.screenWidth,
              height: screenSizeInfo.screenHeight,
              color: DesignListing.getAvailableDesigns()[design].paletteColor,
            );
          },
        );
      },
    );
  }
}
