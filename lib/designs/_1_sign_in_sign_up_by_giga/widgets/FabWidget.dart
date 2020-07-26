import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class FabWidget extends BaseStatelessWidget {
  final double topMargin;
  final VoidCallback onPressed;

  const FabWidget({Key key, @required this.topMargin, this.onPressed})
      : assert(topMargin != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      height: screenSizeInfo.screenWidth * 0.18,
      width: screenSizeInfo.screenWidth * 0.18,
      margin: EdgeInsets.fromLTRB(
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        topMargin,
      ),
      child: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: screenSizeInfo.textSizeMedium,
            ),
            onPressed: onPressed),
      ),
    );
  }
}
