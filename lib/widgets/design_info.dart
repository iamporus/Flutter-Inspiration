import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/design.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base_stateless_widget.dart';

class DesignInfo extends BaseStatelessWidget {
  final Design design;

  DesignInfo({
    Key key,
    @required this.design,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      width: screenSizeInfo.screenWidth,
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Text(
                design.title,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 3.0)],
                    fontSize: screenSizeInfo.textSizeMedium * 1.1,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "by " + design.author,
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: screenSizeInfo.textSizeSmall * 1.4,
                    shadows: [Shadow(blurRadius: 1.0)],
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
