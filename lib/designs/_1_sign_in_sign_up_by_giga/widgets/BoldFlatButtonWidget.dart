import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class BoldFlatButtonWidget extends BaseStatelessWidget {
  final title;
  final color;
  final VoidCallback onPressed;

  const BoldFlatButtonWidget(
      {Key key, @required this.title, @required this.color, this.onPressed})
      : assert(title != null),
        assert(color != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: screenSizeInfo.textSizeLarge,
              fontWeight: FontWeight.bold,
              color: color),
        ),
      ),
    );
  }
}
