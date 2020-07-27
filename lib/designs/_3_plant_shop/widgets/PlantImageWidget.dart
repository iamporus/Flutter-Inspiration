import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

import '../Plant.dart';

class PlantImageWidget extends BaseStatelessWidget {
  const PlantImageWidget({
    Key key,
    @required this.plant,
    @required this.imageSize,
  }) : super(key: key);

  final Plant plant;
  final double imageSize;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return SizedBox(
      width: imageSize,
      child: Hero(
        tag: plant.name,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Image.asset(
              plant.image,
              height: imageSize,
              width: imageSize,
            ),
          ),
        ),
      ),
    );
  }
}
