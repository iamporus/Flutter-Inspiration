import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_design_challenge/models/DesignChangeModel.dart';
import 'package:flutter_design_challenge/models/SettingsCollapseModel.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:provider/provider.dart';

class BackdropWidget extends StatefulWidget {
  const BackdropWidget({
    @required this.settingsScreen,
    @required this.homeBuilder,
  });

  final Widget settingsScreen;
  final Widget Function(BuildContext context, bool isSettingsOpen) homeBuilder;

  @override
  _BackdropWidgetState createState() => _BackdropWidgetState();
}

class _BackdropWidgetState extends State<BackdropWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _settingsPanelController;
  ValueNotifier<bool> _isSettingsOpenNotifier;

  @override
  void initState() {
    super.initState();
    _settingsPanelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _isSettingsOpenNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    _settingsPanelController.dispose();
    _isSettingsOpenNotifier.dispose();
    super.dispose();
  }

  void _toggleSettings() {
    // Animate the settings panel to open or close.
    _settingsPanelController.fling(
        velocity: _isSettingsOpenNotifier.value ? -1 : 1);
    _isSettingsOpenNotifier.value = !_isSettingsOpenNotifier.value;
  }

  Animation<RelativeRect> _slideUpSettingsScreenAnimation(
      BoxConstraints constraints) {
    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, -constraints.maxHeight, 0, 0),
      end: const RelativeRect.fromLTRB(0, 0, 0, 0),
    ).animate(
      CurvedAnimation(
        parent: _settingsPanelController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Animation<RelativeRect> _slideDownHomeScreenAnimation(
      BoxConstraints constraints) {
    final homeActionBarHeight = constraints.biggest.height * 0.2;
    return RelativeRectTween(
      begin: const RelativeRect.fromLTRB(0, 0, 0, 0),
      end: RelativeRect.fromLTRB(
        0,
        constraints.biggest.height - homeActionBarHeight,
        0,
        -homeActionBarHeight,
      ),
    ).animate(
      CurvedAnimation(
        parent: _settingsPanelController,
        curve: const Interval(
          0.0,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Widget settingsPage = ValueListenableBuilder<bool>(
      valueListenable: _isSettingsOpenNotifier,
      builder: (context, isSettingsOpen, child) {
        return widget.settingsScreen;
      },
    );

    final Widget homePage = ValueListenableBuilder<bool>(
      valueListenable: _isSettingsOpenNotifier,
      builder: (context, isSettingsOpen, child) {
        return widget.homeBuilder(context, isSettingsOpen);
      },
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DesignChangeModel>(
            create: (_) => DesignChangeModel()),
        ChangeNotifierProvider<SettingsCollapseModel>(
            create: (_) => SettingsCollapseModel()),
      ],
      child: Stack(
        children: [
          PositionedTransition(
            rect: _slideUpSettingsScreenAnimation(constraints),
            child: settingsPage,
          ),
          PositionedTransition(
            rect: _slideDownHomeScreenAnimation(constraints),
            child: homePage,
          ),
          _SettingsIcon(
            toggleSettings: _toggleSettings,
            isSettingsOpenNotifier: _isSettingsOpenNotifier,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}

class _SettingsIcon extends StatefulWidget {
  final VoidCallback toggleSettings;
  final ValueNotifier<bool> isSettingsOpenNotifier;

  _SettingsIcon({
    Key key,
    this.toggleSettings,
    this.isSettingsOpenNotifier,
  }) : super(key: key);

  @override
  _SettingsIconState createState() => _SettingsIconState();
}

class _SettingsIconState extends State<_SettingsIcon>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 500),
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
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: BaseBuilderWidget(
        builder: (context, screenSizeInfo) {
          return Align(
            alignment: AlignmentDirectional.topStart,
            child: SizedBox(
              width: screenSizeInfo.screenWidth * 0.18,
              height: screenSizeInfo.screenHeight * 0.07 +
                  (screenSizeInfo.safeBlockVertical * 4),
              child: Material(
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                ),
                color: widget.isSettingsOpenNotifier.value
                    ? Colors.transparent
                    : Theme.of(context).colorScheme.secondaryVariant,
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: InkWell(
                  onTap: () {
                    if (widget.isSettingsOpenNotifier.value) {
                      _animationController.reverse();
                      final SettingsCollapseModel settingsCollapseModel =
                          Provider.of<SettingsCollapseModel>(context,
                              listen: false);
                      settingsCollapseModel.isSettingsCollapsedValue = true;
                    } else
                      _animationController.forward();
                    widget.toggleSettings();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
                    child: Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        size: screenSizeInfo.textSizeLarge * 0.8,
                        progress: _animationController,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (widget.isSettingsOpenNotifier.value) {
      _animationController.reverse();
      widget.toggleSettings();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
