import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';

import 'ProfilePageWidget.dart';

class PicturePageViewWidget extends StatefulWidget {
  final dragPosition;
  final profilePictureImage;

  const PicturePageViewWidget(
      {Key key,
      @required this.profilePictureImage,
        @required this.dragPosition})
      : super(key: key);

  @override
  _PicturePageViewWidgetState createState() => _PicturePageViewWidgetState();
}

class _PicturePageViewWidgetState extends State<PicturePageViewWidget> {
  PageController _pageController = PageController(viewportFraction: 0.75);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Container(
        height:
            (screenSizeInfo.screenHeight * 0.85) * (0.40 / widget.dragPosition),
        width: screenSizeInfo.screenWidth,
        child: PageView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            ProfilePageWidget(profilePictureImage: widget.profilePictureImage),
            ProfilePageWidget(profilePictureImage: widget.profilePictureImage),
            ProfilePageWidget(profilePictureImage: widget.profilePictureImage),
          ],
        ),
      );
    });
  }
}
