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
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      child: Container(
        child: Center(
          child: Card(
            clipBehavior: Clip.antiAlias,
            color: Colors.transparent,
            elevation: 8.0,
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
                    AspectRatio(
                      aspectRatio: 0.9,
                      child: Container(
                        color: design.paletteColor,
                        child: CachedNetworkImage(
                          imageUrl: design.imageAsset,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              BlurHash(hash: design.imageHash),
                          placeholderFadeInDuration:
                              Duration(milliseconds: 300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
