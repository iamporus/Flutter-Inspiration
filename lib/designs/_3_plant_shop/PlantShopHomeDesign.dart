import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_design_challenge/designs/_3_plant_shop/PlantDetailsDesign.dart';

import 'Plant.dart';

class PlantShopHomeDesign extends StatelessWidget {
  final tabs = [
    PlantCategoryTabWidget(title: "Top"),
    PlantCategoryTabWidget(title: "Outdoor"),
    PlantCategoryTabWidget(title: "Indoor"),
    PlantCategoryTabWidget(title: "Plant Garden"),
    PlantCategoryTabWidget(title: "Office"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildPlantShopAppBar(),
          body: PlantShopHomeLayout(
            tabs: tabs,
            plants: Plant.getDummyPlants(),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildPlantShopAppBar() {
    return PreferredSize(
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
          child: IconButton(
              icon: Icon(
                Icons.sort,
                color: Colors.black.withAlpha(150),
              ),
              onPressed: () {}),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 18, 18, 0),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black.withAlpha(15),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black.withAlpha(200),
                  ),
                  onPressed: () {}),
            ),
          )
        ],
      ),
      preferredSize: Size.fromHeight(58),
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
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
        );
      });
    });
  }

  void _handlePageChange() {
    double page = _pageController.page;
    if (page == page.roundToDouble()) {
      print("Change change " + _pageController.page.toString());
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(32, 24, 0, 0),
          child: TopPicksWidget(),
        ),
        SizedBox(height: 16),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: CategoryTabBarWidget(
              tabController: _tabController, widget: widget),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          height: MediaQuery.of(context).size.height * 0.5,
          child: PageView(
            controller: _pageController,
            children: <Widget>[
              for (var plant in widget.plants) PlantCardWidget(plant: plant)
            ],
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
          child: Text(
            "Description",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
          ),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.fromLTRB(32, 0, 16, 0),
          child: PlantDescriptionWidget(
              info: widget.plants[_selectedPlantIndex].info),
        ),
      ],
    );
  }
}

class CategoryTabBarWidget extends StatelessWidget {
  const CategoryTabBarWidget({
    Key key,
    @required TabController tabController,
    @required this.widget,
  })  : _tabController = tabController,
        super(key: key);

  final TabController _tabController;
  final PlantShopHomeLayout widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
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

class PlantCardWidget extends StatelessWidget {
  final Plant plant;

  const PlantCardWidget({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.4;
    final cardSize = MediaQuery.of(context).size.height * 0.47;
    final cardWidth = MediaQuery.of(context).size.width * 0.9;
    return Stack(
      children: <Widget>[
        Container(
          height: cardSize,
          width: cardWidth,
          padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Color.fromARGB(255, 45, 161, 95),
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: PlantImageWidget(
                            plant: plant, imageSize: imageSize),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: PlantCategoryWidget(plant: plant),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          child: PlantNameWidget(plant: plant),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
                        child: Row(
                          children: <Widget>[
                            PlantEnvironmentWidget(icon: Icons.wb_sunny),
                            SizedBox(width: 8),
                            PlantEnvironmentWidget(icon: Icons.cloud),
                            SizedBox(width: 8),
                            PlantEnvironmentWidget(icon: Icons.wb_incandescent),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 4, 0),
                          child: Text(
                            "FROM",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: PlantPriceWidget(plant: plant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AddToCartWidget(),
          ),
        ),
        Positioned.fill(
          child: SplashCardWidget(plant: plant),
        )
      ],
    );
  }
}

class SplashCardWidget extends StatelessWidget {
  const SplashCardWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 18, 18, 4),
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

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
      width: MediaQuery.of(context).size.width * 0.50,
      child: CircleAvatar(
          backgroundColor: Colors.black,
          radius: 25,
          child: IconButton(
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {})),
    );
  }
}

class PlantImageWidget extends StatelessWidget {
  const PlantImageWidget({
    Key key,
    @required this.plant,
    @required this.imageSize,
  }) : super(key: key);

  final Plant plant;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      plant.image,
      height: imageSize,
      width: imageSize,
    );
  }
}

class PlantNameWidget extends StatelessWidget {
  const PlantNameWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Text(
      plant.name,
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
    );
  }
}

class PlantCategoryWidget extends StatelessWidget {
  const PlantCategoryWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Text(
      describeEnum(plant.category).toUpperCase(),
      style: TextStyle(
          color: Colors.white, fontSize: 12, fontWeight: FontWeight.w200),
    );
  }
}

class PlantDescriptionWidget extends StatelessWidget {
  const PlantDescriptionWidget({
    Key key,
    @required this.info,
  })  : assert(info != null),
        super(key: key);

  final String info;

  @override
  Widget build(BuildContext context) {
    return Text(
      info,
      style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: 15,
          height: 1.3,
          color: Colors.black),
    );
  }
}

class PlantPriceWidget extends StatelessWidget {
  const PlantPriceWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 0),
      child: Text(
        "\$" + plant.price.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}

class PlantEnvironmentWidget extends StatelessWidget {
  final icon;

  const PlantEnvironmentWidget({
    Key key,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withAlpha(75), width: 1.0),
          borderRadius: BorderRadius.circular(5)),
      child: Icon(
        icon,
        size: 18,
        color: Colors.white.withAlpha(200),
      ),
    );
  }
}

class PlantCategoryTabWidget extends StatelessWidget {
  final title;

  const PlantCategoryTabWidget({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class TopPicksWidget extends StatelessWidget {
  const TopPicksWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Top Picks",
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 28,
        color: Colors.black,
      ),
    );
  }
}
