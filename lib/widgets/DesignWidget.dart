import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:transparent_image/transparent_image.dart';

class DesignWidget extends StatefulWidget {
  final Design design;

  DesignWidget({Key key, @required this.design});

  @override
  _DesignWidgetState createState() => _DesignWidgetState();
}

class _DesignWidgetState extends State<DesignWidget> {
  @override
  void initState() {
    PaletteGenerator _paletteGenerator;
    Future<PaletteGenerator> future = getPaletteGenerator(widget.design);
    future.then((value) {
      _paletteGenerator = value;
      widget.design.paletteColor = _paletteGenerator.darkMutedColor.color;
      setState(() {});
    });
    super.initState();
  }

  Future<PaletteGenerator> getPaletteGenerator(Design design) async {
    return await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(design.imageAsset),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenSizeInfo.paddingLarge,
                screenSizeInfo.paddingSmall,
                screenSizeInfo.paddingLarge,
                screenSizeInfo.paddingSmall),
            child: Card(
              color: widget.design.paletteColor,
              elevation: 3.0,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                      return widget.design.route;
                    }));
                  },
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Container(
                            height: screenSizeInfo.screenHeight * 0.4,
                            child: CachedNetworkImage(
                              imageUrl: widget.design.imageAsset,
                              placeholder: (context, imageUrl) {
                                return Image.memory(kTransparentImage);
                              },
                              placeholderFadeInDuration:
                                  Duration(milliseconds: 300),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
                        child: Text(
                          widget.design.title,
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
                          "by " + widget.design.author,
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
        ),
      );
    });
  }
}
