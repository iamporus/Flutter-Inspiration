import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';

/// A Base class for all Stateless widgets to extend in order to build responsive layouts.
/// Classes extending should implement [buildResponsive] instead of usual [build] method
/// as [buildResponsive] provides [ScreenSizeInfo] object which has all detailed information
/// about screen size, orientation, and text scale factor.
abstract class BaseStatelessWidget extends StatelessWidget {
  const BaseStatelessWidget({Key key}) : super(key: key);

  bool printLogs() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return buildResponsive(
          context, _getScreenSizeInfo(context, boxConstraints));
    });
  }

  @protected
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo);

  ScreenSizeInfo _getScreenSizeInfo(
      BuildContext context, BoxConstraints boxConstraints) {
    return ScreenSizeInfo(
        context: context,
        boxConstraints: boxConstraints,
        printLogs: printLogs());
  }
}
