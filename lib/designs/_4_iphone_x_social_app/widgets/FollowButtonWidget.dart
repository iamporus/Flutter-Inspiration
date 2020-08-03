import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';

class FollowButtonWidget extends StatefulWidget {
  final Duration animationDuration;
  final VoidCallback onTap;

  FollowButtonWidget({Key key, this.animationDuration, this.onTap})
      : super(key: key);

  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  static double _initialButtonWidth;
  static double _finalButtonWidth;
  static Color _initialBorderColor = Colors.red.shade700;
  static Color _finalBorderColor = Colors.white;
  Color _borderColor = _initialBorderColor;
  Color _color = _finalBorderColor;
  double _width = 0.0;
  ButtonState _buttonState = ButtonState.SHOW_TEXT;

  @override
  void didChangeDependencies() {
    _initialButtonWidth = MediaQuery.of(context).size.width * 0.30;
    _finalButtonWidth = MediaQuery.of(context).size.width * 0.13;
    _width = _initialButtonWidth;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      double buttonHeight = screenSizeInfo.screenHeight * 0.06;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _changeState,
          child: AnimatedContainer(
            height: buttonHeight,
            width: _width,
            duration: widget.animationDuration,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: _borderColor)),
            child: _buttonState == ButtonState.SHOW_ICON
                ? Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  )
                : Center(
                    child: Text(
                      "FOLLOW",
                      style: TextStyle(
                          wordSpacing: 1.1,
                          fontWeight: FontWeight.bold,
                          color: _initialBorderColor,
                          fontSize: screenSizeInfo.textSizeSmall * 1.5),
                    ),
                  ),
          ),
        ),
      );
    });
  }

  void _changeState() {
    setState(() {
      _width = (_width == _initialButtonWidth)
          ? _finalButtonWidth
          : _initialButtonWidth;
      _borderColor = (_borderColor == _initialBorderColor)
          ? _finalBorderColor
          : _initialBorderColor;
      _color = (_color == _initialBorderColor)
          ? _finalBorderColor
          : _initialBorderColor;
      _buttonState = (_buttonState == ButtonState.SHOW_TEXT)
          ? ButtonState.SHOW_ICON
          : ButtonState.SHOW_TEXT;
    });
  }
}

enum ButtonState { SHOW_TEXT, SHOW_ICON }
