import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

class DesignWidget extends BaseStatelessWidget {
  final Design design;

  DesignWidget({
    Key key,
    @required this.design,
  });

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        0,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingMedium,
      ),
      child: Center(
        child: Card(
          color: Colors.transparent,
          elevation: 4.0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return design.route;
                  },
                ));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    height: screenSizeInfo.screenHeight * 0.48,
                    width: screenSizeInfo.screenHeight * 0.48,
                    child: CachedNetworkImage(
                      imageUrl: design.imageAsset,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => AspectRatio(
                        aspectRatio: 0.9,
                        child: BlurHash(hash: design.imageHash),
                      ),
                      placeholderFadeInDuration: Duration(milliseconds: 300),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
