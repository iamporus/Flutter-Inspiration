import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/utils/ScreenSizeInfo.dart';
import 'package:flutter_design_challenge/widgets/BaseStatelessWidget.dart';

import 'widgets/AddToCartWidget.dart';
import 'widgets/FloatingUpArrowWidget.dart';
import 'widgets/GameInfoWidget.dart';
import 'widgets/GamePriceWidget.dart';
import 'widgets/GameTitleWidget.dart';

class GameAppConceptDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameAppConceptLayout(
      game: Game(
          "Ghost of Tsushima",
          "Ghost of Tsushima is an action-adventure stealth game played from a third-person perspective. It feature a large open world without any waypoints and can be explored without guidance. Players can quickly travel to different parts of the game's world by riding a horse.",
          59.99,
          "assets/ghost_preview.png"),
    );
  }
}

class Game {
  final String title;
  final String info;
  final double priceInDollars;
  final String imagePath;

  Game(this.title, this.info, this.priceInDollars, this.imagePath);
}

class GameAppConceptLayout extends BaseStatelessWidget {
  final Game game;

  GameAppConceptLayout({@required this.game});

  AppBar _buildAppBar(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return new AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
          child: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.redAccent.shade400,
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(game.imagePath),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          appBar: _buildAppBar(context, screenSizeInfo),
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.fromLTRB(screenSizeInfo.paddingSmall, 0, 0,
                screenSizeInfo.paddingXLarge),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingUpArrowWidget(
                onPressed: () {
                  _showModalBottomSheet(context, screenSizeInfo);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet(
      BuildContext context, ScreenSizeInfo screenSizeInfo) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        enableDrag: true,
        isScrollControlled: false,
        barrierColor: Colors.black.withAlpha(50),
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(50.0),
                topRight: const Radius.circular(50.0),
              ),
            ),
            child: GameInfoCard(game: game),
            padding: EdgeInsets.all(screenSizeInfo.paddingMedium),
          );
        });
  }
}

class GameInfoCard extends BaseStatelessWidget {
  final Game game;

  const GameInfoCard({
    Key key,
    @required this.game,
  }) : super(key: key);

  @override
  bool printLogs() {
    return true;
  }

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GameTitleWidget(
          gameTitle: game.title,
        ),
        GameInfoWidget(
          infoText: game.info,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                screenSizeInfo.paddingSmall, 0, screenSizeInfo.paddingSmall, 0),
            child: GamePriceWidget(
              priceInDollars: game.priceInDollars,
            ),
          ),
        ),
        SizedBox(
          width: screenSizeInfo.screenWidth,
          child: AddToCartWidget(),
        )
      ],
    );
  }
}
