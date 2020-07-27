import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

import 'Plant.dart';
import 'PlantDetailsDesign.dart';
import 'widgets/PlantShopAppBar.dart';

class PlantShopHomeDesign extends BaseStatelessWidget {
  final tabs = [
    _PlantCategoryTabWidget(title: "Top"),
    _PlantCategoryTabWidget(title: "Outdoor"),
    _PlantCategoryTabWidget(title: "Indoor"),
    _PlantCategoryTabWidget(title: "Plant Garden"),
    _PlantCategoryTabWidget(title: "Office"),
  ];

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildPlantShopAppBar(context, screenSizeInfo),
          body: PlantShopHomeLayout(
            tabs: tabs,
            plants: Plant.getDummyPlants(),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildPlantShopAppBar(
      BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return PreferredSize(
      child: PlantShopAppBar(
        leadingIcon: Icon(
          Icons.sort,
          color: Colors.black.withAlpha(150),
        ),
        shopActionIcon: Icon(
          Icons.shopping_cart,
          color: Colors.black.withAlpha(150),
        ),
      ),
      preferredSize: Size.fromHeight(screenSizeInfo.paddingMedium * 2.5),
    );
  }

  @override
  bool printLogs() {
    return true;
  }
}

class PlantShopHomeLayout extends StatefulWidget {
  final List<Plant> plants;
  final tabs;

  PlantShopHomeLayout({Key key, @required this.tabs, @required this.plants})
      : assert(plants != null),
        assert(tabs != null),
        super(key: key);

  @override
  _PlantShopHomeLayoutState createState() => _PlantShopHomeLayoutState();
}

class _PlantShopHomeLayoutState extends State<PlantShopHomeLayout>
    with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(viewportFraction: 0.75);
  TabController _tabController;
  int _selectedPlantIndex = 0;
  num _noOfPlantsInCategory = 2;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabs.length, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabChange);
    _pageController.addListener(_handlePageChange);
  }

  void _handleTabChange() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        _pageController.animateTo(
          (_tabController.index * _noOfPlantsInCategory) *
              MediaQuery.of(context).size.width *
              0.8,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 500),
        );
      });
    });
  }

  void _handlePageChange() {
    double page = _pageController.page;
    if (page == page.roundToDouble()) {
      setState(() {
        _selectedPlantIndex = _pageController.page.toInt();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(
                screenSizeInfo.paddingLarge, screenSizeInfo.paddingSmall, 0, 0),
            child: _TopPicksWidget(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingMedium, 0, 0, 0),
            child: _CategoryTabBarWidget(
                tabController: _tabController, widget: widget),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screenSizeInfo.paddingSmall),
            padding: EdgeInsets.fromLTRB(screenSizeInfo.paddingSmall, 0, 0, 0),
            height: screenSizeInfo.screenHeight * 0.51,
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                for (var plant in widget.plants) _PlantCardWidget(plant: plant)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingLarge, 0, 0, 0),
            child: Text(
              "Description",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: screenSizeInfo.paddingMedium,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingLarge, 0,
                screenSizeInfo.paddingMedium, 0),
            child: _PlantDescriptionWidget(
                info: widget.plants[_selectedPlantIndex].info),
          ),
        ],
      );
    });
  }
}

class _CategoryTabBarWidget extends BaseStatelessWidget {
  const _CategoryTabBarWidget({
    Key key,
    @required TabController tabController,
    @required this.widget,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final PlantShopHomeLayout widget;

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
            tabs: widget.tabs,
          ),
        ),
      ),
    );
  }
}

class _PlantCardWidget extends BaseStatelessWidget {
  final Plant plant;

  const _PlantCardWidget({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Stack(
      children: <Widget>[
        Container(
          height: screenSizeInfo.screenHeight * 0.48,
          width: screenSizeInfo.screenWidth * 0.9,
          padding: EdgeInsets.fromLTRB(0, 0, screenSizeInfo.paddingSmall, 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Color.fromARGB(255, 45, 161, 95),
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: screenSizeInfo.paddingLarge,
                      ),
                      Center(
                        child: _PlantImageWidget(
                            plant: plant,
                            imageSize: screenSizeInfo.screenWidth * 0.4),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenSizeInfo.paddingMedium,
                              4,
                              screenSizeInfo.paddingMedium,
                              4),
                          child: _PlantCategoryWidget(plant: plant),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenSizeInfo.paddingMedium,
                              0,
                              screenSizeInfo.paddingMedium,
                              screenSizeInfo.paddingMedium),
                          child: _PlantNameWidget(plant: plant),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenSizeInfo.paddingMedium,
                            0,
                            0,
                            screenSizeInfo.paddingSmall),
                        child: Row(
                          children: <Widget>[
                            _PlantEnvironmentWidget(icon: Icons.wb_sunny),
                            SizedBox(width: screenSizeInfo.paddingSmall),
                            _PlantEnvironmentWidget(icon: Icons.cloud),
                            SizedBox(width: screenSizeInfo.paddingSmall),
                            _PlantEnvironmentWidget(
                                icon: Icons.wb_incandescent),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenSizeInfo.screenWidth * 0.70,
                  padding: EdgeInsets.fromLTRB(0, screenSizeInfo.paddingSmall,
                      screenSizeInfo.paddingMedium, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, screenSizeInfo.paddingSmall, 4, 0),
                          child: Text(
                            "FROM",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSizeInfo.textSizeSmall,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: _PlantPriceWidget(plant: plant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, screenSizeInfo.paddingMedium, 0, 0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(child: _AddToCartWidget()),
          ),
        ),
        Positioned.fill(
          child: _SplashCardWidget(plant: plant),
        )
      ],
    );
  }
}

class _SplashCardWidget extends BaseStatelessWidget {
  const _SplashCardWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            4, screenSizeInfo.paddingMedium, screenSizeInfo.paddingMedium, 4),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return PlantDetailsDesign(plant: plant);
          })),
        ),
      ),
    );
  }
}

class _AddToCartWidget extends BaseStatelessWidget {
  const _AddToCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, screenSizeInfo.paddingSmall, 0),
      width: screenSizeInfo.screenWidth * 0.50,
      child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: screenSizeInfo.paddingSmall * 2.5,
          child: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: screenSizeInfo.textSizeMedium,
              ),
              onPressed: () {})),
    );
  }
}

class _PlantImageWidget extends BaseStatelessWidget {
  const _PlantImageWidget({
    Key key,
    @required this.plant,
    @required this.imageSize,
  }) : super(key: key);

  final Plant plant;
  final double imageSize;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Image.asset(
      plant.image,
      height: imageSize,
      width: imageSize,
    );
  }
}

class _PlantNameWidget extends BaseStatelessWidget {
  const _PlantNameWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      plant.name,
      style: TextStyle(
        color: Colors.white,
        fontSize: screenSizeInfo.textSizeMedium,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PlantCategoryWidget extends BaseStatelessWidget {
  const _PlantCategoryWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      describeEnum(plant.category).toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: screenSizeInfo.textSizeSmall,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class _PlantDescriptionWidget extends BaseStatelessWidget {
  const _PlantDescriptionWidget({
    Key key,
    @required this.info,
  })  : assert(info != null),
        super(key: key);

  final String info;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      info + '\n',
      maxLines: 4,
      style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: screenSizeInfo.textSizeMedium,
          height: 1.2,
          color: Colors.black),
    );
  }
}

class _PlantPriceWidget extends BaseStatelessWidget {
  const _PlantPriceWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "\$" + plant.price.toString(),
      style: TextStyle(
          color: Colors.white,
          fontSize: screenSizeInfo.textSizeSmall * 2,
          fontWeight: FontWeight.w400),
    );
  }
}

class _PlantEnvironmentWidget extends BaseStatelessWidget {
  final icon;

  const _PlantEnvironmentWidget({
    Key key,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Container(
      padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withAlpha(75), width: 1.0),
          borderRadius: BorderRadius.circular(5)),
      child: Icon(
        icon,
        size: screenSizeInfo.textSizeMedium,
        color: Colors.white.withAlpha(200),
      ),
    );
  }
}

class _PlantCategoryTabWidget extends BaseStatelessWidget {
  final title;

  const _PlantCategoryTabWidget({
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
          fontSize: screenSizeInfo.textSizeMedium,
        ),
      ),
    );
  }
}

class _TopPicksWidget extends BaseStatelessWidget {
  const _TopPicksWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "Top Picks",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: screenSizeInfo.textSizeSmall * 2,
        color: Colors.black,
      ),
    );
  }
}
