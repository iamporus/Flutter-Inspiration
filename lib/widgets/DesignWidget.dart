import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:google_fonts/google_fonts.dart';

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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
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
                  child: Stack(
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 1.1,
                          child: Container(
                            height: screenSizeInfo.screenHeight * 0.3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: widget.design.imageAsset,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => AspectRatio(
                                  aspectRatio: 1.1,
                                  child:
                                      BlurHash(hash: widget.design.imageHash),
                                ),
                                placeholderFadeInDuration:
                                    Duration(milliseconds: 300),
                              ),
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: screenSizeInfo.screenWidth,
                          padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              widget.design.paletteColor == null
                                  ? Colors.black.withOpacity(0.4)
                                  : widget.design.paletteColor,
                              Colors.transparent
                            ],
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.design.title,
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            screenSizeInfo.textSizeMedium)),
                              ),
                              SizedBox(
                                height: screenSizeInfo.paddingSmall * 0.5,
                              ),
                              Text(
                                "by " + widget.design.author,
                                style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSizeInfo.textSizeSmall * 1.3,
                                  fontWeight: FontWeight.w300,
                                )),
                              ),
                            ],
                          ),
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
