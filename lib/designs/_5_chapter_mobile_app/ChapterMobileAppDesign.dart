import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_5_chapter_mobile_app/ChapterHomeDesign.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterMobileAppDesign extends BaseStatelessWidget {
  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return SafeArea(
        child: Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "assets/vision.svg",
              color: Colors.black,
              semanticsLabel: 'Eyeglasses',
            ),
            Image.asset("assets/humaaans.png"),
            Text(
              "Best reading app in your pocket",
              textAlign: TextAlign.center,
              style: GoogleFonts.quicksand(
                textStyle: TextStyle(
                  color: Color(0xFF331128),
                  fontSize: screenSizeInfo.textSizeMedium * 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ChapterHomeDesign();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF331128),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenSizeInfo.paddingMedium * 1.5),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(
                  screenSizeInfo.paddingLarge,
                  screenSizeInfo.paddingMedium,
                  screenSizeInfo.paddingLarge,
                  screenSizeInfo.paddingMedium,
                ),
                child: Text('Start reading',
                    style: TextStyle(
                      fontSize: screenSizeInfo.textSizeMedium,
                      color: Colors.white,
                    )),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
