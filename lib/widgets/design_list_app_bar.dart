import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_logo.dart';
import 'base_stateless_widget.dart';

class DesignListAppBar extends BaseStatelessWidget {
  final String appBarTitle;

  const DesignListAppBar({
    @required this.appBarTitle,
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      width: screenSizeInfo.screenWidth,
      padding: EdgeInsets.only(
        top: screenSizeInfo.paddingSmall,
        right: screenSizeInfo.paddingSmall,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          AppLogo(
            radius: screenSizeInfo.paddingMedium * 1.5,
            anim: AppLogoAnim.IDLE,
          ),
          SizedBox(
            width: screenSizeInfo.paddingSmall,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              appBarTitle,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                    fontSize: screenSizeInfo.textSizeMedium * 1.4,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 3.0)]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
