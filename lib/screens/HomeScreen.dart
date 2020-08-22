import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_design_challenge/widgets/BackdropWidget.dart';
import 'package:showcaseview/showcase_widget.dart';

import 'DesignListScreen.dart';
import 'SettingsScreen.dart';

class HomeScreen extends StatelessWidget {
  final bool isFirstTime;

  const HomeScreen({
    Key key,
    this.isFirstTime = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isFirstTime
        ? _buildBackdropWidgetWithShowcase()
        : _buildBackdropWidget();
  }

  BackdropWidget _buildBackdropWidget() {
    return BackdropWidget(
      settingsScreen: SettingsScreen(),
      homeBuilder: (context, isSettingsOpen) {
        return DesignListScreen(
          isSettingsOpen: isSettingsOpen,
          isFirstTime: isFirstTime,
        );
      },
    );
  }

  Widget _buildBackdropWidgetWithShowcase() {
    return ShowCaseWidget(
      builder: Builder(builder: (context) {
        return _buildBackdropWidget();
      }),
    );
  }
}
