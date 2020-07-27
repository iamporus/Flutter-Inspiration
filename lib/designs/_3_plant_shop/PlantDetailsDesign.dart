import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_3_plant_shop/widgets/PlantImageWidget.dart';
import 'package:flutter_design_challenge/designs/_3_plant_shop/widgets/PlantShopAppBar.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

import 'Plant.dart';

class PlantDetailsDesign extends BaseStatelessWidget {
  final Plant plant;

  const PlantDetailsDesign({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  PreferredSize _buildPlantShopAppBar(
      BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return PreferredSize(
      preferredSize: Size.fromHeight(screenSizeInfo.paddingMedium * 2.5),
      child: PlantShopAppBar(
        leadingIcon: Icon(
          Icons.arrow_back,
          color: Colors.white.withAlpha(150),
        ),
        shopActionIcon: Icon(
          Icons.shopping_cart,
          color: Colors.white.withAlpha(200),
        ),
      ),
    );
  }

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 49, 160, 95),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildPlantShopAppBar(context, screenSizeInfo),
          body: _PlantShopLayout(
            plant: plant,
          ),
        ),
      ),
    );
  }
}

class _PlantShopLayout extends BaseStatelessWidget {
  final Plant plant;

  const _PlantShopLayout({Key key, @required this.plant})
      : assert(plant != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    final imageSize = screenSizeInfo.screenWidth * 0.6;
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingXLarge,
                    screenSizeInfo.paddingMedium, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _CategoryWidget(
                      categoryTitle: "INDOOR",
                    ),
                    _PlantTitleWidget(title: plant.name),
                    SizedBox(
                      height: screenSizeInfo.paddingMedium,
                    ),
                    _CategoryWidget(
                      categoryTitle: "FROM",
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingSmall * 0.5,
                    ),
                    _PlantPriceWidget(
                      priceInDollars: plant.price,
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingMedium,
                    ),
                    _CategoryWidget(
                      categoryTitle: "SIZES",
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingSmall * 0.5,
                    ),
                    _PlantSizeWidget(
                      plantSize: plant.size,
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingLarge,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: _AddToCartWidget(),
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingSmall,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: PlantInfoWidget(plant: plant),
                  width: screenSizeInfo.screenWidth,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, screenSizeInfo.paddingSmall, 0),
          child: Align(
              alignment: Alignment(1.3, -0.5),
              child: PlantImageWidget(
                plant: plant,
                imageSize: imageSize,
              )),
        )
      ],
    );
  }
}

class PlantInfoWidget extends BaseStatelessWidget {
  const PlantInfoWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          screenSizeInfo.paddingLarge, 0, screenSizeInfo.paddingMedium, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _AllToKnowWidget(),
          _PlantInfoWidget(plant: plant),
          _DetailsWidget(),
          _PlantDetailsWidget(plant: plant),
        ],
      ),
    );
  }
}

class _DetailsWidget extends BaseStatelessWidget {
  const _DetailsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "Details",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: screenSizeInfo.textSizeSmall * 2,
      ),
    );
  }
}

class _AllToKnowWidget extends BaseStatelessWidget {
  const _AllToKnowWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "All to know...",
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: screenSizeInfo.textSizeMedium * 1.5,
      ),
    );
  }
}

class _PlantDetailsWidget extends BaseStatelessWidget {
  const _PlantDetailsWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Plant height: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: screenSizeInfo.textSizeSmall * 1.4,
              ),
            ),
            Text(
              plant.heightInCm,
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: screenSizeInfo.textSizeSmall * 1.4),
            )
          ],
        ),
        SizedBox(height: 4,),
        Row(
          children: <Widget>[
            Text(
              "Nursery pot width: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontSize: screenSizeInfo.textSizeSmall * 1.4,
              ),
            ),
            Text(
              plant.potWidthInCm,
              style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: screenSizeInfo.textSizeSmall * 1.4),
            )
          ],
        )
      ],
    );
  }
}

class _PlantInfoWidget extends BaseStatelessWidget {
  const _PlantInfoWidget({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      plant.info,
      style: TextStyle(
        color: Colors.black,
        height: 1.5,
        fontWeight: FontWeight.w200,
        fontSize: screenSizeInfo.textSizeSmall * 1.4,
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
    return CircleAvatar(
      radius: screenSizeInfo.paddingLarge,
      backgroundColor: Colors.black.withAlpha(230),
      child: IconButton(
          icon: Icon(
            Icons.add_shopping_cart,
            size: screenSizeInfo.textSizeLarge,
            color: Colors.white,
          ),
          onPressed: () {}),
    );
  }
}

class _PlantTitleWidget extends BaseStatelessWidget {
  final title;

  const _PlantTitleWidget({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      title,
      style: TextStyle(
        fontSize: screenSizeInfo.textSizeLarge,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _PlantPriceWidget extends BaseStatelessWidget {
  final priceInDollars;

  const _PlantPriceWidget({Key key, @required this.priceInDollars})
      : assert(priceInDollars != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      "\$" + priceInDollars.toString(),
      style: TextStyle(
        fontSize: screenSizeInfo.textSizeMedium,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _PlantSizeWidget extends BaseStatelessWidget {
  final PlantSize plantSize;

  const _PlantSizeWidget({Key key, @required this.plantSize})
      : assert(plantSize != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      describeEnum(plantSize),
      style: TextStyle(
        fontSize: screenSizeInfo.textSizeMedium,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _CategoryWidget extends BaseStatelessWidget {
  final categoryTitle;

  const _CategoryWidget({Key key, @required this.categoryTitle})
      : assert(categoryTitle != null),
        super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      categoryTitle,
      style: TextStyle(
        fontSize: screenSizeInfo.textSizeSmall,
        color: Colors.white.withAlpha(125),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
