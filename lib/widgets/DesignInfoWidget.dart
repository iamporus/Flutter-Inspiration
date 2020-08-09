import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BaseStatelessWidget.dart';

class DesignInfoWidget extends BaseStatelessWidget {
  final Design design;

  DesignInfoWidget({
    Key key,
    @required this.design,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      width: screenSizeInfo.screenWidth,
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 2.0,
              color: Colors.black,
            )
          ],
          gradient: LinearGradient(
            colors: [
              design.paletteColor,
              Colors.black,
            ],
          )),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              design.title,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: screenSizeInfo.textSizeMedium * 1.2,
                ),
              ),
            ),
            Text(
              "by " + design.author,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: screenSizeInfo.textSizeSmall * 1.5,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
