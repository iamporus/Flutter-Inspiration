import 'dart:async';
import 'package:flutter/material.dart';

class ShowUpTransition extends StatefulWidget {
  final Widget child;
  final AxisDirection direction;
  final int delayInMilliseconds;
  final int animationDurationInMilliseconds;

  ShowUpTransition({
    Key key,
    @required this.child,
    this.delayInMilliseconds,
    this.animationDurationInMilliseconds = 500,
    this.direction,
  }) : super(key: key);

  @override
  _ShowUpTransitionState createState() => _ShowUpTransitionState();
}

class _ShowUpTransitionState extends State<ShowUpTransition>
    with TickerProviderStateMixin {
  AnimationController _animController;
  Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.animationDurationInMilliseconds,
        ));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: _getOffset(), end: Offset.zero).animate(curve);

    if (widget.delayInMilliseconds == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayInMilliseconds), () {
        _animController.forward();
      });
    }
  }

  Offset _getOffset() {
    switch (widget.direction) {
      case AxisDirection.down:
        return Offset(0.0, -0.3);
      case AxisDirection.up:
        return Offset(0.0, 1.0);
      case AxisDirection.left:
        return Offset(-1.0, 0.0);
      case AxisDirection.right:
        return Offset(1.0, 0.0);
      default:
        return Offset(0.0, 1.0);
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}
