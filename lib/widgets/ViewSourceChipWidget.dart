import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'BaseStatelessWidget.dart';

class ViewSourceChipWidget extends BaseStatelessWidget {
  const ViewSourceChipWidget({
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
        _launchURL(context, _currentDesign.sourceCodeUrl);
      },
      onDeleted: () {
        _launchURL(context, _currentDesign.sourceCodeUrl);
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

  _launchURL(BuildContext context, String sourceCodeUrl) async {
    if (await canLaunch(sourceCodeUrl)) {
      await launch(sourceCodeUrl);
      //TODO: force WebView with desktop site
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not launch $sourceCodeUrl'),
        ),
      );
    }
  }
}
