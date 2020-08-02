import 'package:flutter/material.dart';

class FollowButtonWidget extends StatefulWidget {
  final Duration animationDuration;
  final VoidCallback onTap;

  FollowButtonWidget({Key key, this.animationDuration, this.onTap})
      : super(key: key);

  @override
  _FollowButtonWidgetState createState() => _FollowButtonWidgetState();
}

class _FollowButtonWidgetState extends State<FollowButtonWidget> {
  static double _initialButtonWidth = 100;
  static double _finalButtonWidth = 45;
  static Color _initialBorderColor = Colors.red.shade700;
  static Color _finalBorderColor = Colors.white;
  Color _borderColor = _initialBorderColor;
  Color _color = _finalBorderColor;
  double _width = _initialButtonWidth;
  ButtonState _buttonState = ButtonState.SHOW_TEXT;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _changeState,
        child: AnimatedContainer(
          height: 40,
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
                    ),
                  ),
                ),
        ),
      ),
    );
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
