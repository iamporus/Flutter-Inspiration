import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class TextFormFieldWidget extends BaseStatelessWidget {
  const TextFormFieldWidget({
    Key key,
    @required this.name,
    @required this.labelColor,
    @required this.underlineColor,
  })  : assert(name != null),
        assert(labelColor != null),
        assert(underlineColor != null),
        super(key: key);

  final String name;
  final Color labelColor;
  final Color underlineColor;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingMedium,
          screenSizeInfo.paddingSmall,
          screenSizeInfo.paddingSmall,
          screenSizeInfo.paddingSmall),
      child: TextFormField(
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: screenSizeInfo.textSizeMedium,
            color: Colors.pink.shade300),
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: name,
            contentPadding: EdgeInsets.all(8),
            labelStyle: TextStyle(color: labelColor),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: underlineColor)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: underlineColor))),
      ),
    );
  }
}
