import 'package:flutter/widgets.dart';
import 'package:flutter_design_challenge/main.dart';

enum DeviceScreenType { Mobile, Tablet, Desktop }

class ScreenSizeInfo {
  double _safeAreaHorizontal;
  double _safeAreaVertical;
  Size _screenSize;

  Size widgetSize;

  Orientation orientation;
  DeviceScreenType deviceScreenType;

  double screenWidth;
  double screenHeight;

  double blockSizeHorizontal;
  double blockSizeVertical;

  double textScaleFactor;

  double safeBlockHorizontal;
  double safeBlockVertical;

  double paddingSmall;

  /// about 6px on small phones
  double paddingMedium;
  double paddingLarge;
  double paddingXLarge;

  /// about 6px on small phones
  double textSizeSmall;
  double textSizeMedium;
  double textSizeLarge;
  double textSizeXLarge;

  ScreenSizeInfo({
    @required BuildContext context,
    @required BoxConstraints boxConstraints,
    @required bool printLogs,
  }) {
    var mediaQueryData = MediaQuery.of(context);

    //device current orientation
    orientation = mediaQueryData.orientation;

    //device screen sizes
    _screenSize = mediaQueryData.size;

    screenWidth = this._screenSize.shortestSide.roundToDouble();
    screenHeight = this._screenSize.longestSide.roundToDouble();

    //device type
    deviceScreenType = _getDeviceType(screenWidth);

    //block sizes for appropriate widget scaling
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    //text scaling factor
    setupTextScalingFactor();

    setupPadding();

    setupTextSizes();

    //safe areas to avoid clipping
    setupSafeAreas(mediaQueryData);

    //widget sizes to know and debug exact size taken by widgets
    widgetSize = Size(boxConstraints.maxWidth, boxConstraints.maxHeight);

    if (!kReleaseMode || printLogs) print(this);
  }

  void setupTextScalingFactor() {
    if (orientation == Orientation.portrait) {
      textScaleFactor = blockSizeVertical;
    } else {
      textScaleFactor = blockSizeHorizontal;
    }
  }

  void setupSafeAreas(MediaQueryData mediaQueryData) {
    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  DeviceScreenType _getDeviceType(double deviceWidth) {
    if (deviceWidth > 1024) {
      return DeviceScreenType.Desktop;
    }
    if (deviceWidth >= 600) {
      return DeviceScreenType.Tablet;
    }
    return DeviceScreenType.Mobile;
  }

  void setupPadding() {
    paddingSmall = (textScaleFactor * 1.5).roundToDouble();
    paddingMedium = (textScaleFactor * 2.5).roundToDouble();
    paddingLarge = (textScaleFactor * 4.5).roundToDouble();
    paddingXLarge = (textScaleFactor * 6).roundToDouble();
  }

  void setupTextSizes() {
    textSizeSmall = (textScaleFactor * 1.5).roundToDouble();
    textSizeMedium = (textScaleFactor * 2.5).roundToDouble();
    textSizeLarge = (textScaleFactor * 4.5).roundToDouble();
    textSizeXLarge = (textScaleFactor * 6).roundToDouble();
  }

  @override
  String toString() {
    return '''ScreenSizeInfo{ '
        'orientation: $orientation,'
        'textScaleFactor: $textScaleFactor,'
        'paddingSmall: $paddingSmall,'
        'paddingMedium: $paddingMedium,'
        'paddingLarge: $paddingLarge,'
        'paddingXLarge: $paddingXLarge,'
        'deviceScreenType: $deviceScreenType,'
        'screenWidth: $screenWidth, '
        'screenHeight: $screenHeight,'
        'blockSizeHorizontal: $blockSizeHorizontal, '
        'blockSizeVertical: $blockSizeVertical,'
        'safeBlockHorizontal: $safeBlockHorizontal, '
        'safeBlockVertical: $safeBlockVertical,'
        'widgetSize: $widgetSize,}''';
  }
}
