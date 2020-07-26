import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class UnderlinedFlatButtonWidget extends BaseStatelessWidget {
  final title;
  final color;

  const UnderlinedFlatButtonWidget({
    Key key,
    @required this.title,
    @required this.color,
  })  : assert(title != null),
        assert(color != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      alignment: Alignment.centerLeft,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(
              fontSize: screenSizeInfo.textSizeMedium,
              decoration: TextDecoration.underline,
              color: color),
        ),
      ),
    );
  }
}
