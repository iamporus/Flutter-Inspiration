import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      child: _PlantShopAppBar(
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
                    _CategoryText(
                      categoryTitle: "INDOOR",
                    ),
                    _PlantTitleText(title: plant.name),
                    SizedBox(
                      height: screenSizeInfo.paddingMedium,
                    ),
                    _CategoryText(
                      categoryTitle: "FROM",
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingSmall * 0.5,
                    ),
                    _PlantPriceText(
                      priceInDollars: plant.price,
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingMedium,
                    ),
                    _CategoryText(
                      categoryTitle: "SIZES",
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingSmall * 0.5,
                    ),
                    _PlantSizeText(
                      plantSize: plant.size,
                    ),
                    SizedBox(
                      height: screenSizeInfo.paddingLarge,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: _AddToCartButton(),
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
                  child: _PlantInfoHolder(plant: plant),
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
              child: _PlantImage(
                plant: plant,
                imageSize: imageSize,
              )),
        )
      ],
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

class _PlantInfoHolder extends BaseStatelessWidget {
  const _PlantInfoHolder({
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
          const _AllToKnowHeader(),
          _PlantInfoText(plantInfo: plant.info),
          const _DetailsHeader(),
          _PlantDetails(plant: plant),
        ],
      ),
    );
  }
}

class _DetailsHeader extends BaseStatelessWidget {
  const _DetailsHeader({
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

class _AllToKnowHeader extends BaseStatelessWidget {
  const _AllToKnowHeader({
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

class _PlantDetails extends BaseStatelessWidget {
  const _PlantDetails({
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
        SizedBox(
          height: 4,
        ),
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

class _PlantInfoText extends BaseStatelessWidget {
  const _PlantInfoText({
    Key key,
    @required this.plantInfo,
  }) : super(key: key);

  final String plantInfo;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Text(
      plantInfo,
      style: TextStyle(
        color: Colors.black,
        height: 1.5,
        fontWeight: FontWeight.w200,
        fontSize: screenSizeInfo.textSizeSmall * 1.4,
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

class _PlantTitleText extends BaseStatelessWidget {
  final title;

  const _PlantTitleText({
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

class _PlantPriceText extends BaseStatelessWidget {
  final double priceInDollars;

  const _PlantPriceText({Key key, @required this.priceInDollars})
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

class _PlantSizeText extends BaseStatelessWidget {
  final PlantSize plantSize;

  const _PlantSizeText({
    Key key,
    @required this.plantSize,
  })  : assert(plantSize != null),
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

class _CategoryText extends BaseStatelessWidget {
  final categoryTitle;

  const _CategoryText({
    Key key,
    @required this.categoryTitle,
  })  : assert(categoryTitle != null),
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
