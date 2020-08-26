import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class FloatingUpArrowWidget extends BaseStatelessWidget {
  final VoidCallback onPressed;

  const FloatingUpArrowWidget({
    Key key,
    @required this.onPressed,
  })  : assert(onPressed != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: CircleAvatar(
        radius: screenSizeInfo.textSizeLarge,
        backgroundColor: Colors.black.withAlpha(150),
        child: IconButton(
            iconSize: screenSizeInfo.textSizeLarge,
            icon: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.red,
              size: screenSizeInfo.textSizeLarge,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
