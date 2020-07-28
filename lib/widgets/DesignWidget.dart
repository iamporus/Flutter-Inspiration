import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class DesignWidget extends BaseStatelessWidget {
  final Design design;

  const DesignWidget({Key key, @required this.design});

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return design.route;
        }));
      },
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenSizeInfo.paddingLarge,
                screenSizeInfo.paddingSmall,
                screenSizeInfo.paddingLarge,
                screenSizeInfo.paddingSmall),
            child: Card(
              color: Colors.blueGrey.shade500,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Container(
                          decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                          image: NetworkImage(
                            design.imageAsset,
                            scale: 2,
                          ),
                        ),
                      ))),
                  Padding(
                    padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
                    child: Text(
                      design.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenSizeInfo.paddingSmall,
                        0,
                        screenSizeInfo.paddingSmall,
                        screenSizeInfo.paddingSmall),
                    child: Text(
                      "by " + design.author,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
