import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BaseStatelessWidget.dart';

class DesignListAppBarWidget extends BaseStatelessWidget {
  final String appBarTitle;

  const DesignListAppBarWidget({
    @required this.appBarTitle,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      width: screenSizeInfo.screenWidth,
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          appBarTitle,
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
                fontSize: screenSizeInfo.textSizeMedium * 1.3,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 3.0)]),
          ),
        ),
      ),
    );
  }
}
