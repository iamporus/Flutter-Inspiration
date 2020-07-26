import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class GameInfoWidget extends BaseStatelessWidget {
  final infoText;

  const GameInfoWidget({Key key, @required this.infoText})
      : assert(infoText != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      infoText,
      maxLines:
          screenSizeInfo.deviceScreenType == DeviceScreenType.Mobile ? 7 : 12,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: screenSizeInfo.textSizeMedium,
          wordSpacing: 2,
          height: 1.5),
    );
  }
}
