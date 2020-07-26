import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class AddToCartWidget extends BaseStatelessWidget {
  const AddToCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return FlatButton(
        onPressed: () {},
        color: Colors.redAccent.shade700,
        child: Padding(
          padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
          child: Text(
            "Add to Cart",
            style: TextStyle(
              fontSize: screenSizeInfo.textSizeMedium,
              color: Colors.white,
            ),
          ),
        ));
  }
}
