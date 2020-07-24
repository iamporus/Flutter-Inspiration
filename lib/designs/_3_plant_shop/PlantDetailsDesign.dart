import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Plant.dart';

class PlantDetailsDesign extends StatelessWidget {
  final Plant plant;

  const PlantDetailsDesign({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 49, 160, 95),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildPlantShopAppBar(context),
          body: _PlantShopLayout(
            plant: plant,
          ),
        ),
      ),
    );
  }

  PreferredSize _buildPlantShopAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(58),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.fromLTRB(24, 24, 0, 0),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white.withAlpha(150),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 24, 24, 0),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white.withAlpha(25),
              child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ),
          )
        ],
      ),
    );
  }
}

class _PlantShopLayout extends StatelessWidget {
  final Plant plant;

  const _PlantShopLayout({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.6;

    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(48, 8, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    _CategoryWidget(
                      categoryTitle: "INDOOR",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    _PlantTitleWidget(title: plant.name),
                    SizedBox(
                      height: 24,
                    ),
                    _CategoryWidget(
                      categoryTitle: "FROM",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    _PlantPriceWidget(
                      priceInDollars: plant.price,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    _CategoryWidget(
                      categoryTitle: "SIZES",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    _PlantSizeWidget(
                      plantSize: plant.size,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: _AddToCartWidget(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: _buildPlantInfoLayout(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  width: MediaQuery.of(context).size.width,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
          child: Align(
              alignment: Alignment(0.9, -0.4),
              child: Image.asset(
                plant.image,
                height: imageSize,
                width: imageSize,
              )),
        )
      ],
    );
  }

  _buildPlantInfoLayout() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          _AllToKnowWidget(),
          SizedBox(
            height: 32,
          ),
          _PlantInfoWidget(plant: plant),
          SizedBox(
            height: 32,
          ),
          _DetailsWidget(),
          SizedBox(
            height: 8,
          ),
          _PlantHeightWidget(plant: plant),
          SizedBox(
            height: 8,
          ),
          _PotInfoWidget(plant: plant)
        ],
      ),
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  const _DetailsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Details",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    );
  }
}

class _AllToKnowWidget extends StatelessWidget {
  const _AllToKnowWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "All to know...",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
    );
  }
}

class _PlantHeightWidget extends StatelessWidget {
  const _PlantHeightWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Plant height: ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        Text(
          plant.heightInCm,
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}

class _PotInfoWidget extends StatelessWidget {
  const _PotInfoWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          "Nursery pot width: ",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        Text(
          plant.potWidthInCm,
          style: TextStyle(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}

class _PlantInfoWidget extends StatelessWidget {
  const _PlantInfoWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Text(
      plant.info,
      style: TextStyle(
        color: Colors.black,
        height: 1.5,
        fontWeight: FontWeight.w300,
        fontSize: 14,
      ),
    );
  }
}

class _AddToCartWidget extends StatelessWidget {
  const _AddToCartWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black.withAlpha(230),
      child: IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}

class _PlantTitleWidget extends StatelessWidget {
  final title;

  const _PlantTitleWidget({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _PlantPriceWidget extends StatelessWidget {
  final priceInDollars;

  const _PlantPriceWidget({Key key, @required this.priceInDollars})
      : assert(priceInDollars != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "\$" + priceInDollars.toString(),
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PlantSizeWidget extends StatelessWidget {
  final PlantSize plantSize;

  const _PlantSizeWidget({Key key, @required this.plantSize})
      : assert(plantSize != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      describeEnum(plantSize),
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _CategoryWidget extends StatelessWidget {
  final categoryTitle;

  const _CategoryWidget({Key key, @required this.categoryTitle})
      : assert(categoryTitle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      categoryTitle,
      style: TextStyle(
        fontSize: 12,
        color: Colors.white.withAlpha(125),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
