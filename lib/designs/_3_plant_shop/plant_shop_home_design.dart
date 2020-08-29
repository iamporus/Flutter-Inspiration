import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_design_challenge/utils/screen_size_info.dart';
import 'package:flutter_design_challenge/widgets/base_responsive_builder.dart';
import 'package:flutter_design_challenge/widgets/base_stateless_widget.dart';

import 'plant.dart';
import 'plant_details_design.dart';

class PlantShopHomeDesign extends BaseStatelessWidget {
  final List<_PlantCategoryTab> tabs = [
    _PlantCategoryTab(title: "Top"),
    _PlantCategoryTab(title: "Outdoor"),
    _PlantCategoryTab(title: "Indoor"),
    _PlantCategoryTab(title: "Plant Garden"),
    _PlantCategoryTab(title: "Office"),
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
      child: _PlantShopAppBar(
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
}

class _PlantShopAppBar extends BaseStatelessWidget {
  final Icon leadingIcon;

  final Icon shopActionIcon;

  const _PlantShopAppBar({
    Key key,
    @required this.leadingIcon,
    @required this.shopActionIcon,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingMedium, 0, 0, 0),
        child: IconButton(
            icon: leadingIcon,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, screenSizeInfo.paddingMedium, 0),
          child: CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black.withAlpha(15),
            child: IconButton(icon: shopActionIcon, onPressed: () {}),
          ),
        )
      ],
    );
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

  Widget _plantDescriptionWidget;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.tabs.length, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabChange);
    _pageController.addListener(_handlePageChange);
    _plantDescriptionWidget = _PlantDescriptionText(
      info: widget.plants[0].info,
      key: ValueKey(0),
    );
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
        _plantDescriptionWidget = _PlantDescriptionText(
          key: ValueKey(page),
          info: widget.plants[_selectedPlantIndex].info,
        );
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
            child: _TopPicksHeader(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingMedium, 0, 0, 0),
            child: _CategoryTabBar(
                tabController: _tabController, tabs: widget.tabs),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, screenSizeInfo.paddingSmall),
            padding: EdgeInsets.fromLTRB(screenSizeInfo.paddingSmall, 0, 0, 0),
            height: screenSizeInfo.screenHeight * 0.51,
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                for (var plant in widget.plants) _PlantCard(plant: plant)
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
              child: AnimatedSwitcher(
                duration: Duration(
                  milliseconds: 300,
                ),
                child: _plantDescriptionWidget,
              )),
        ],
      );
    });
  }
}

class _TopPicksHeader extends BaseStatelessWidget {
  const _TopPicksHeader({
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

class _CategoryTabBar extends BaseStatelessWidget {
  const _CategoryTabBar({
    Key key,
    @required TabController tabController,
    @required this.tabs,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final List<_PlantCategoryTab> tabs;

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

class _PlantCard extends BaseStatelessWidget {
  final Plant plant;

  const _PlantCard({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    timeDilation = 1.5;

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
                        child: _PlantImage(
                            plant: plant,
                            imageSize: screenSizeInfo.screenWidth * 0.4,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return PlantDetailsDesign(plant: plant);
                                }),
                              );
                            }),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              screenSizeInfo.paddingMedium,
                              4,
                              screenSizeInfo.paddingMedium,
                              4),
                          child: _PlantCategoryText(category: plant.category),
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
                          child: _PlantNameText(plantName: plant.name),
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
                            const _PlantEnvironmentWidget(icon: Icons.wb_sunny),
                            SizedBox(width: screenSizeInfo.paddingSmall),
                            const _PlantEnvironmentWidget(icon: Icons.cloud),
                            SizedBox(width: screenSizeInfo.paddingSmall),
                            const _PlantEnvironmentWidget(
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
                        child: _PlantPriceText(price: plant.price),
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
            child: Container(child: const _AddToCartButton()),
          ),
        ),
        Positioned.fill(
          child: _SplashPlantCard(plant: plant),
        )
      ],
    );
  }
}

class _SplashPlantCard extends BaseStatelessWidget {
  const _SplashPlantCard({
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

class _AddToCartButton extends BaseStatelessWidget {
  const _AddToCartButton({
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

class _PlantNameText extends BaseStatelessWidget {
  const _PlantNameText({
    Key key,
    @required this.plantName,
  }) : super(key: key);

  final String plantName;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      plantName,
      style: TextStyle(
        color: Colors.white,
        fontSize: screenSizeInfo.textSizeMedium,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PlantCategoryText extends BaseStatelessWidget {
  const _PlantCategoryText({
    Key key,
    @required this.category,
  }) : super(key: key);

  final PlantCategory category;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      describeEnum(category).toUpperCase(),
      style: TextStyle(
        color: Colors.white,
        fontSize: screenSizeInfo.textSizeSmall,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

class _PlantImage extends BaseStatelessWidget {
  final VoidCallback onTap;
  final Plant plant;
  final double imageSize;

  const _PlantImage({
    Key key,
    @required this.plant,
    @required this.imageSize,
    this.onTap,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return SizedBox(
      width: imageSize,
      child: Hero(
        tag: plant.name,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              plant.image,
              height: imageSize,
              width: imageSize,
            ),
          ),
        ),
      ),
    );
  }
}

class _PlantDescriptionText extends BaseStatelessWidget {
  const _PlantDescriptionText({
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
          fontWeight: FontWeight.w200,
          fontSize: screenSizeInfo.textSizeSmall * 1.3,
          height: 1.4,
          color: Colors.black),
    );
  }
}

class _PlantPriceText extends BaseStatelessWidget {
  const _PlantPriceText({
    Key key,
    @required this.price,
  }) : super(key: key);

  final double price;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "\$" + price.toString(),
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

class _PlantCategoryTab extends BaseStatelessWidget {
  final String title;

  const _PlantCategoryTab({
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
