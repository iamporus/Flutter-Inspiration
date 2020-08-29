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
