import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PlantShopDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 49, 160, 95),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildPlantShopAppBar(),
          body: PlantShopLayout(
            plant: getDummyPlant(),
          ),
        ),
      ),
    );
  }

  Plant getDummyPlant() {
    return Plant(
        name: "Ficus",
        category: PlantCategory.Indoor,
        price: 30,
        heightInCm: "35-45cm",
        potWidthInCm: "12cm",
        size: PlantSize.Small,
        image: "assets/ficus_plant.png",
        info:
            "If you're completely new to houseplants then Ficus is a brilliant first plant to adopt, it is very easy to look after and won't occupy too much space.");
  }

  PreferredSize _buildPlantShopAppBar() {
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
              onPressed: () {}),
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

class PlantShopLayout extends StatelessWidget {
  final Plant plant;

  const PlantShopLayout({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    CategoryWidget(
                      categoryTitle: "INDOOR",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PlantTitleWidget(title: plant.name),
                    SizedBox(
                      height: 24,
                    ),
                    CategoryWidget(
                      categoryTitle: "FROM",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PlantPriceWidget(
                      priceInDollars: plant.price,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    CategoryWidget(
                      categoryTitle: "SIZES",
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    PlantSizeWidget(
                      plantSize: plant.size,
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: AddToCartWidget(),
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
              alignment: Alignment(0.8, -0.8),
              child: Image.asset(
                plant.image,
                scale: 1.1,
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
          AllToKnowWidget(),
          SizedBox(
            height: 32,
          ),
          PlantInfoWidget(plant: plant),
          SizedBox(
            height: 32,
          ),
          DetailsWidget(),
          SizedBox(
            height: 8,
          ),
          PlantHeightWidget(plant: plant),
          SizedBox(
            height: 8,
          ),
          PotInfoWidget(plant: plant)
        ],
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
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

class AllToKnowWidget extends StatelessWidget {
  const AllToKnowWidget({
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

class PlantHeightWidget extends StatelessWidget {
  const PlantHeightWidget({
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

class PotInfoWidget extends StatelessWidget {
  const PotInfoWidget({
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

class PlantInfoWidget extends StatelessWidget {
  const PlantInfoWidget({
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

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({
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

enum PlantSize { Small, Medium, Large }
enum PlantCategory { Indoor, Outdoor }

class Plant {
  final name;
  final PlantSize size;
  final PlantCategory category;
  final double price;
  final heightInCm;
  final potWidthInCm;
  final image;
  final info;

  const Plant(
      {Key key,
      @required this.name,
      @required this.category,
      @required this.price,
      @required this.size,
      @required this.image,
      @required this.info,
      @required this.heightInCm,
      @required this.potWidthInCm})
      : assert(name != null),
        assert(category != null),
        assert(price != null),
        assert(size != null),
        assert(image != null),
        assert(info != null),
        assert(heightInCm != null),
        assert(potWidthInCm != null);
}

class PlantTitleWidget extends StatelessWidget {
  final title;

  const PlantTitleWidget({
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

class PlantPriceWidget extends StatelessWidget {
  final priceInDollars;

  const PlantPriceWidget({Key key, @required this.priceInDollars})
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

class PlantSizeWidget extends StatelessWidget {
  final PlantSize plantSize;

  const PlantSizeWidget({Key key, @required this.plantSize})
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

class CategoryWidget extends StatelessWidget {
  final categoryTitle;

  const CategoryWidget({Key key, @required this.categoryTitle})
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
