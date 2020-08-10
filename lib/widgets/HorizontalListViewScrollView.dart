import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';

import 'BaseStatelessWidget.dart';

class HorizontalListWheelScrollView extends BaseStatelessWidget {
  final Widget Function(BuildContext, int) builder;
  final Axis scrollDirection;
  final FixedExtentScrollController controller;
  final double itemExtent;
  final double diameterRatio;
  final void Function(int) onSelectedItemChanged;
  final double squeeze;
  final VoidCallback onTap;

  final ScrollPhysics scrollPhysics;

  const HorizontalListWheelScrollView({
    Key key,
    @required this.builder,
    @required this.itemExtent,
    this.onSelectedItemChanged,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.diameterRatio = 7,
    this.squeeze,
    this.onTap,
    this.scrollPhysics,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return GestureDetector(
      onTap: onTap,
      child: RotatedBox(
        quarterTurns: scrollDirection == Axis.horizontal ? 3 : 0,
        child: ListWheelScrollView.useDelegate(
          onSelectedItemChanged: onSelectedItemChanged,
          controller: controller,
          itemExtent: itemExtent,
          squeeze: squeeze,
          diameterRatio: diameterRatio,
          physics: scrollPhysics,
          childDelegate: ListWheelChildLoopingListDelegate(
              children: List<Widget>.generate(
                  DesignListing.getAvailableDesignCount(),
                  (index) => RotatedBox(
                        quarterTurns:
                            scrollDirection == Axis.horizontal ? 1 : 0,
                        child: builder(context, index),
                      ))),
        ),
      ),
    );
  }
}
