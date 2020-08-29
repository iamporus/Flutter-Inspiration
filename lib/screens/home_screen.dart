import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_design_challenge/widgets/backdrop.dart';
import 'package:showcaseview/showcase_widget.dart';

import 'design_list_screen.dart';
import 'settings_screen.dart';

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

  Backdrop _buildBackdropWidget() {
    return Backdrop(
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
      onFinish: () {
        dissolveFirstTimeState();
      },
    );
  }
}
