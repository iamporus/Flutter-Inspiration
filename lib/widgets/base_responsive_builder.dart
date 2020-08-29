import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';

/// Widget layouts inside Stateful widgets should parent this Widget.
/// as it provides [ScreenSizeInfo] object which has all detailed information
/// about screen size, orientation, and text scale factor; required to create a
/// responsive layout.
class BaseBuilderWidget extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenSizeInfo screenSizeInfo)
      builder;

  final bool printLogs;

  const BaseBuilderWidget(
      {Key key, @required this.builder, this.printLogs = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, boxConstraints) {
      return builder(
          context,
          _getScreenSizeInfo(
            context,
            boxConstraints,
          ));
    });
  }

  ScreenSizeInfo _getScreenSizeInfo(
      BuildContext context, BoxConstraints boxConstraints) {
    return ScreenSizeInfo(
      context: context,
      boxConstraints: boxConstraints,
      printLogs: printLogs,
    );
  }
}
