import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class ChapterHomeDesign extends StatefulWidget {
  @override
  _ChapterHomeDesignState createState() => _ChapterHomeDesignState();
}

class _ChapterHomeDesignState extends State<ChapterHomeDesign>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;

  bool _canPageChange = true;

  @override
  void initState() {
    _pageController = PageController()..addListener(_handlePageChange);
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabChange);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Scaffold(
          appBar: _buildAppBar(context, screenSizeInfo),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              const _UserInfoHeader(),
              SizedBox(
                height: screenSizeInfo.paddingLarge,
              ),
              const _SearchBar(),
              _CategoryTabBar(tabController: _tabController, tabs: [
                const _CategoryTab(title: "Featured"),
                const _CategoryTab(title: "Latest"),
                const _CategoryTab(title: "Followed"),
              ]),
              Flexible(
                fit: FlexFit.tight,
                child: Container(
                  width: screenSizeInfo.screenWidth,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      const _CategoryPage(),
                      const _CategoryPage(),
                      const _CategoryPage()
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _handlePageChange() {
    int page = _pageController.page.round();
    if (_canPageChange) {
      _tabController.animateTo(
        page,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleTabChange() async {
    _canPageChange = false;
    await _pageController.animateToPage(
      _tabController.index,
      duration: Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
    _canPageChange = true;
  }
}

PreferredSize _buildAppBar(
    BuildContext context, ScreenSizeInfo screenSizeInfo) {
  return PreferredSize(
    preferredSize: Size.fromHeight(screenSizeInfo.screenHeight * 0.1),
    child: Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.drag_handle,
            color: Colors.black,
            size: screenSizeInfo.paddingLarge,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
  );
}

class _SearchBar extends BaseStatelessWidget {
  const _SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        screenSizeInfo.paddingLarge,
        screenSizeInfo.paddingMedium,
        screenSizeInfo.paddingLarge,
        screenSizeInfo.paddingMedium,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          fillColor: Colors.grey.shade300,
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 1.0),
              borderRadius: BorderRadius.all(
                Radius.circular(screenSizeInfo.paddingMedium * 1.5),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(screenSizeInfo.paddingMedium * 1.5),
              ),
              borderSide: BorderSide(color: Colors.transparent)),
        ),
      ),
    );
  }
}

class _UserInfoHeader extends BaseStatelessWidget {
  const _UserInfoHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Anna Berg",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: screenSizeInfo.textSizeLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: screenSizeInfo.screenWidth / 6,
          height: screenSizeInfo.screenWidth / 6,
          child: ClipRRect(
            borderRadius:
                BorderRadius.all(Radius.circular(screenSizeInfo.paddingMedium)),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "https://images.unsplash.com/photo-1485778303651-5df62b8ba895?ixlib=rb-1.2.1&auto=format&fit=crop&h=200&q=80",
            ),
          ),
        )
      ],
    );
  }
}

class _CategoryTabBar extends BaseStatelessWidget {
  const _CategoryTabBar({
    Key key,
    @required TabController tabController,
    @required this.tabs,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<_CategoryTab> tabs;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return SizedBox(
      height: screenSizeInfo.paddingLarge * 1.9,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.transparent,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w200,
            ),
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}

class _CategoryTab extends BaseStatelessWidget {
  final String title;

  const _CategoryTab({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Tab(
      iconMargin: EdgeInsets.all(0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: screenSizeInfo.textSizeMedium * 1.2,
        ),
      ),
    );
  }
}

class _CategoryPage extends BaseStatelessWidget {
  const _CategoryPage({Key key}) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return ListView(
      children: [
        _CategoryArticle(
          imageUrl: "assets/humaaans.png",
          title: "10 tips on how to improve the UX",
          subtitle: "Apr 28 - 6 min read",
        ),
        _CategoryArticle(
          imageUrl: "assets/humaaans_1.png",
          title: "Interior design advice from top world experts",
          subtitle: "Apr 21 - 23 min read",
        ),
        _CategoryArticle(
          imageUrl: "assets/humaaans_2.png",
          title: "Expert's opinion on boosting productivity",
          subtitle: "Apr 12 - 8 min read",
        ),
        _CategoryArticle(
          imageUrl: "assets/humaaans_3.png",
          title: "UI/UX guidelines for Material Design",
          subtitle: "Apr 02 - 9 min read",
        )
      ],
    );
  }
}

class _CategoryArticle extends BaseStatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  _CategoryArticle({this.imageUrl, this.title, this.subtitle});

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
      child: ListTile(
        onTap: () {},
        leading: Container(
            width: screenSizeInfo.screenWidth / 4,
            decoration: BoxDecoration(
                color: Color(0xFFFAE2D8),
                borderRadius: BorderRadius.all(
                    Radius.circular(screenSizeInfo.paddingSmall))),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
            )),
        title: Text(
          title,
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: screenSizeInfo.textSizeMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
          child: Text(
            subtitle,
            style: GoogleFonts.quicksand(
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: screenSizeInfo.textSizeSmall,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
