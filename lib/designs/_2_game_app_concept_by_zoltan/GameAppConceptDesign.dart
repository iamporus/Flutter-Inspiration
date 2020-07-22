import 'package:flutter/material.dart';

import 'widgets/AddToCartWidget.dart';
import 'widgets/FloatingUpArrowWidget.dart';
import 'widgets/GameInfoWidget.dart';
import 'widgets/GamePriceWidget.dart';
import 'widgets/GameTitleWidget.dart';

class GameAppConceptDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameAppConceptLayout();
  }
}

class GameAppConceptLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/ghost_preview.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          appBar: _buildAppBar(context),
          backgroundColor: Colors.transparent,
          body: _buildLayout(context),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
          padding: const EdgeInsets.all(8.0),
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

  Container _buildLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingUpArrowWidget(
          onPressed: () {
            _showModalBottomSheet(context);
          },
        ),
      ),
    );
  }
}

void _showModalBottomSheet(BuildContext context) {
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
          child: _getGameDescription(),
          padding: EdgeInsets.all(12.0),
        );
      });
}

Column _getGameDescription() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      GameTitleWidget(
        gameTitle: 'Ghost of Tsushima',
      ),
      GameInfoWidget(
        infoText:
            "Ghost of Tsushima is an action-adventure stealth game played from a third-person perspective. It feature a large open world without any waypoints and can be explored without guidance. Players can quickly travel to different parts of the game's world by riding a horse.  it revolves around Jin Sakai, one of the last samurai on Tsushima Island during the first Mongol invasion of Japan in 1274.",
      ),
      Align(
        alignment: Alignment.topRight,
        child: GamePriceWidget(
          priceInDollars: 59.99,
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: AddToCartWidget(),
      )
    ],
  );
}
