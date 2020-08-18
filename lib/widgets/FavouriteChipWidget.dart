import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';
import 'package:flutter_design_challenge/utils/analytics_service.dart';
import 'package:flutter_design_challenge/widgets/BaseBuilderWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteChipWidget extends StatefulWidget {
  const FavouriteChipWidget({
    Key key,
    @required Design currentDesign,
  })  : _currentDesign = currentDesign,
        super(key: key);

  final Design _currentDesign;

  @override
  _FavouriteChipWidgetState createState() => _FavouriteChipWidgetState();
}

const String PREFS_KEY_FAVOURITE = "_isFavourite";

class _FavouriteChipWidgetState extends State<FavouriteChipWidget>
    with TickerProviderStateMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  AnimationController _animationController;
  Animation<Color> _backgroundTweenColor;

  bool _isFavourite = false;
  String _designPrefsKey;

  @override
  void initState() {
    _getFavoriteState();

    Color _beginColor = Colors.transparent;
    Color _endColor =
        _isFavourite ? widget._currentDesign.paletteColor : Colors.pink;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
    );

    _backgroundTweenColor = _getBackgroundColorTween(_beginColor, _endColor);

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Animation<Color> _getBackgroundColorTween(Color beginColor, Color endColor) {
    return ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(_animationController);
  }

  Future _getFavoriteState() async {
    final SharedPreferences prefs = await _prefs;
    _designPrefsKey =
        "design_" + widget._currentDesign.id.toString() + PREFS_KEY_FAVOURITE;
    _isFavourite = prefs.get(_designPrefsKey) ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseBuilderWidget(builder: (context, screenSizeInfo) {
      return ActionChip(
        labelPadding: EdgeInsets.all(screenSizeInfo.paddingSmall * 0.5),
        onPressed: () {
          _changeFavoriteState();
        },
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.zero,
            bottomRight: Radius.zero,
            bottomLeft: Radius.circular(20),
          ),
        ),
        label: Text(
          "Favorite",
          style: GoogleFonts.quicksand(
            textStyle: TextStyle(
              color: widget._currentDesign.paletteColor,
              fontSize: screenSizeInfo.textSizeMedium * 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        avatar: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            child: _isFavourite
                ? Icon(
                    Icons.favorite,
                    size: screenSizeInfo.textSizeMedium * 1.5,
                    color: _backgroundTweenColor.value,
                  )
                : Icon(
                    Icons.favorite_border,
                    size: screenSizeInfo.textSizeMedium * 1.5,
                    color: _backgroundTweenColor.value,
                  ),
          ),
        ),
      );
    });
  }

  void _changeFavoriteState() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(_designPrefsKey, !_isFavourite).then((value) {
      _isFavourite = !_isFavourite;
      AnalyticsService().logFavoriteMarked(widget._currentDesign.id);

      setState(() {
        _animationController.forward();
      });
    });
  }
}
