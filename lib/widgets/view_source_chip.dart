import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/design.dart';
import 'package:flutter_design_challenge/utils/analytics_service.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import 'base_stateless_widget.dart';

class ViewSourceChip extends BaseStatelessWidget {
  const ViewSourceChip({
    Key key,
    @required Design currentDesign,
  })  : _currentDesign = currentDesign,
        super(key: key);

  final Design _currentDesign;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return RawChip(
      labelPadding: EdgeInsets.all(screenSizeInfo.paddingSmall * 0.5),
      deleteIcon: Icon(
        Icons.code,
        color: _currentDesign.paletteColor,
        size: screenSizeInfo.textSizeMedium * 1.5,
      ),
      elevation: 15,
      pressElevation: 10,
      onPressed: () {
        AnalyticsService().logViewSourceClicked(_currentDesign.id);
        launchURL(context, _currentDesign.sourceCodeUrl);
      },
      onDeleted: () {
        AnalyticsService().logViewSourceClicked(_currentDesign.id);
        launchURL(context, _currentDesign.sourceCodeUrl);
      },
      deleteButtonTooltipMessage: "View Source",
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.zero,
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.zero,
      )),
      label: Text(
        "View Source",
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            color: _currentDesign.paletteColor,
            fontSize: screenSizeInfo.textSizeMedium * 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
