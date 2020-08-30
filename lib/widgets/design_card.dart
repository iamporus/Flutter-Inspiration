import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_design_challenge/models/design.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';

class DesignCard extends BaseStatelessWidget {
  final Design design;

  DesignCard({
    Key key,
    @required this.design,
  });

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return design.route;
            },
          ));
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(screenSizeInfo.paddingMedium * 1.5),
                topRight: Radius.circular(screenSizeInfo.paddingMedium * 1.5)),
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: Colors.transparent,
              elevation: 8.0,
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(screenSizeInfo.paddingMedium),
                        topRight:
                            Radius.circular(screenSizeInfo.paddingMedium),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: design.imageAsset,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            BlurHash(hash: design.imageHash),
                        placeholderFadeInDuration: Duration(milliseconds: 300),
                      ),
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
