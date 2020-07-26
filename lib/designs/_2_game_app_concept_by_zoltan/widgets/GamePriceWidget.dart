import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class GamePriceWidget extends BaseStatelessWidget {
  final priceInDollars;

  const GamePriceWidget({Key key, @required this.priceInDollars})
      : assert(priceInDollars != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "\$" + priceInDollars.toString(),
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: screenSizeInfo.textSizeLarge,
      ),
    );
  }
}
