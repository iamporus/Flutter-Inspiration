import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/DesignListing.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:flutter_design_challenge/widgets/DesignWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignListScreen extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
        body: Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: new AppBar(
        elevation: 0.0,
        title: Padding(
          padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
          child: Text(
            "Flutter Design Gallery",
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                fontSize: screenSizeInfo.textSizeMedium * 1.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: DesignListing.getAvailableDesignCount(),
            itemBuilder: (context, i) {
              return DesignWidget(
                  design: DesignListing.getAvailableDesigns()[i]);
            }),
      ),
    ));
  }
}
