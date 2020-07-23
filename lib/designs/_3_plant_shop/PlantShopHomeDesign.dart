import 'package:flutter/material.dart';
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
            plants: getDummyPlants(),
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

  getDummyPlants() {
    return {
      Plant(
          name: "Ficus",
          category: PlantCategory.Indoor,
          price: 30,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/ficus_plant.png",
          info:
              "If you're completely new to houseplants then Ficus is a brilliant first plant to adopt, it is very easy to look after and won't occupy too much space."),
      Plant(
          name: "Ficus",
          category: PlantCategory.Indoor,
          price: 30,
          heightInCm: "35-45cm",
          potWidthInCm: "12cm",
          size: PlantSize.Small,
          image: "assets/ficus_plant.png",
          info:
              "If you're completely new to houseplants then Ficus is a brilliant first plant to adopt, it is very easy to look after and won't occupy too much space.")
    };
  }
}

class PlantShopHomeLayout extends StatefulWidget {
  final plants;
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
  TabController _tabController;
  int currentTab = 0;

  var _selectedTab;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length,initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {

    setState(() {
      _selectedTab = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(32, 32, 0, 0), child: TopPicksWidget()),
        SizedBox(
          height: 32,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 0, 0),
          child: SizedBox(
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
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(_tabController.index.toString()),
          ),
        )
      ],
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
        fontSize: 34,
        color: Colors.black,
      ),
    );
  }
}
