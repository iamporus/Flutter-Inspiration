import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class GameTitleWidget extends BaseStatelessWidget {
  final gameTitle;

  const GameTitleWidget({Key key, @required this.gameTitle})
      : assert(gameTitle != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        gameTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: screenSizeInfo.textSizeMedium * 1.5,
        ),
      ),
    );
  }
}
