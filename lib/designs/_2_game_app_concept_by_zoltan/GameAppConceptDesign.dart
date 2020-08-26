import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/designs/_4_iphone_x_social_app/IPhoneXSocialAppDesign.dart';
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
          "assets/ghost.webp"),
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

  @override
  _GameAppConceptLayoutState createState() => _GameAppConceptLayoutState();
}

class _GameAppConceptLayoutState extends State<GameAppConceptLayout>
    with TickerProviderStateMixin {
  AnimationController _imageHeightController;
  AnimationController _sheetHeightController;

  static const double _minExtent = 0.0;
  static const double _sheetMaxExtent = 0.52;
  static const double _imageMaxExtent = 0.40;
  double initialExtent = _minExtent;

  double _dragPosition = 0.0;
  Animation<double> _imageHeightTween;
  Animation<double> _sheetHeightTween;

  bool isExpanded = false;
  bool isDragging = false;

  double _floatingArrowOpacity = 1.0;

  @override
  void initState() {
    _imageHeightController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _sheetHeightController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _imageHeightTween = Tween(
      begin: _minExtent,
      end: _imageMaxExtent,
    ).animate(
      CurvedAnimation(
        parent: _imageHeightController,
        curve: Curves.easeOut,
      ),
    );
    _sheetHeightTween = Tween(
      begin: _minExtent,
      end: _sheetMaxExtent,
    ).animate(
      CurvedAnimation(
        parent: _sheetHeightController,
        curve: Curves.easeOut,
      ),
    );

    _imageHeightController.addListener(() {
      setState(() {});
    });
    _sheetHeightController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _imageHeightController.dispose();
    _sheetHeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(
      builder: (context, screenSizeInfo) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              _buildGameBackground(),
              _buildGameInfoCardLayout(screenSizeInfo),
              _buildFloatingButton(screenSizeInfo),
              SafeArea(
                child: _GameAppBar(),
              )
            ],
          ),
        );
      },
    );
  }

  Positioned _buildFloatingButton(ScreenSizeInfo screenSizeInfo) {
    return Positioned(
      bottom: screenSizeInfo.paddingLarge,
      left: screenSizeInfo.screenWidth / 2 - screenSizeInfo.textSizeLarge * 1.5,
      child: AnimatedOpacity(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 250),
        opacity: _floatingArrowOpacity,
        child: FloatingUpArrowWidget(
          onPressed: () {
            isDragging = false;
            setState(() {
              if (!isExpanded) {
                _imageHeightController.reset();
                _showBottomSheet();
              } else {
                _hideBottomSheet();
              }
              isExpanded = !isExpanded;
            });
          },
        ),
      ),
    );
  }

  GestureDetector _buildGameBackground() {
    return GestureDetector(
      onTap: () {
        if (isExpanded) {
          _hideBottomSheet();
          setState(() {
            isExpanded = !isExpanded;
          });
        }
      },
      child: _GameBackgroundImageWidget(
        widget: widget,
        isDragging: isDragging,
        imageHeightTween: _imageHeightTween,
        dragPosition: _dragPosition,
      ),
    );
  }

  StreamBuilder _buildGameInfoCardLayout(ScreenSizeInfo screenSizeInfo) {
    return StreamBuilder(builder: (context, snapshot) {
      return NotificationListener<DraggableScrollableNotification>(
        onNotification: (notification) {
          _dragPosition = notification.extent;
          isDragging = true;
          if (_dragPosition == 0.0) {
            _floatingArrowOpacity = 1.0;
            isExpanded = false;
            _sheetHeightController.reset();
          }
          setState(() {});
          return true;
        },
        child: ScrollConfiguration(
          behavior: GlowLessScrollBehavior(),
          child: DraggableScrollableActuator(
            child: DraggableScrollableSheet(
              key: Key(_sheetHeightController.value.toString()),
              initialChildSize: _sheetHeightTween.value,
              minChildSize: _minExtent,
              maxChildSize: _sheetMaxExtent,
              expand: true,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  physics: new ClampingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                      ),
                    ),
                    child: _GameInfoCard(game: widget.game),
                    padding: EdgeInsets.all(screenSizeInfo.paddingLarge),
                  ),
                );
              },
            ),
          ),
        ),
      );
    });
  }

  void _showBottomSheet() {
    _sheetHeightController.forward();
    _imageHeightController.forward();
    _floatingArrowOpacity = 0.0;
  }

  void _hideBottomSheet() {
    _imageHeightController.reverse();
    _sheetHeightController.reverse();
    _floatingArrowOpacity = 1.0;
  }
}

class _GameAppBar extends BaseStatelessWidget {
  const _GameAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(screenSizeInfo.paddingSmall),
        height: screenSizeInfo.screenHeight * 0.10,
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.pinkAccent,
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class _GameBackgroundImageWidget extends BaseStatelessWidget {
  const _GameBackgroundImageWidget({
    Key key,
    @required this.widget,
    @required this.isDragging,
    @required Animation<double> imageHeightTween,
    @required double dragPosition,
  })  : _imageHeightTween = imageHeightTween,
        _dragPosition = dragPosition,
        super(key: key);

  final GameAppConceptLayout widget;
  final bool isDragging;
  final Animation<double> _imageHeightTween;
  final double _dragPosition;

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    double height = screenSizeInfo.screenHeight;
    return Container(
      height: !isDragging
          ? height - (height * _imageHeightTween.value)
          : height - (height * (_dragPosition - 0.12)),
      width: screenSizeInfo.screenWidth,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Image.asset(
          widget.game.imagePath,
        ),
      ),
    );
  }
}

class _GameInfoCard extends BaseStatelessWidget {
  final Game game;

  const _GameInfoCard({
    Key key,
    @required this.game,
  }) : super(key: key);

  @override
  Widget buildResponsive(BuildContext context, ScreenSizeInfo screenSizeInfo) {
    return Column(
      children: <Widget>[
        GameTitleWidget(
          gameTitle: game.title,
        ),
        SizedBox(
          height: screenSizeInfo.paddingSmall * 1.5,
        ),
        GameInfoWidget(
          infoText: game.info,
        ),
        SizedBox(
          height: screenSizeInfo.paddingSmall * 1.5,
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
          height: screenSizeInfo.paddingSmall * 1.5,
        ),
        SizedBox(
          width: screenSizeInfo.screenWidth,
          child: AddToCartWidget(),
        )
      ],
    );
  }
}
