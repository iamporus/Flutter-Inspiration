import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_4_iphone_x_social_app/StateCurrentPage.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:provider/provider.dart';

import '../UserProfile.dart';
import 'ProfilePageWidget.dart';

class PicturePageViewWidget extends StatefulWidget {
  final dragPosition;
  final List<UserProfile> userProfiles;

  const PicturePageViewWidget({
    Key key,
    @required this.userProfiles,
    @required this.dragPosition,
  }) : super(key: key);

  @override
  _PicturePageViewWidgetState createState() => _PicturePageViewWidgetState();
}

class _PicturePageViewWidgetState extends State<PicturePageViewWidget> {
  PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  @override
  void initState() {
    _pageController.addListener(_handlePageChange);
    super.initState();
  }

  void _handlePageChange() {
    final profileModal = Provider.of<StateCurrentPage>(context, listen: false);
    double page = _pageController.page;
//    if (page.roundToDouble() == page) {
    setState(() {
      _selectedPageIndex = _pageController.page.toInt();
      profileModal.currentPageValue = _selectedPageIndex;
    });
//    }
  }

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
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (var profile in widget.userProfiles)
              ProfilePageWidget(profilePictureImage: profile.profileImage),
          ],
        ),
      );
    });
  }
}
