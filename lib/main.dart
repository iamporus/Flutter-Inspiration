import 'dart:async';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_design_challenge/screens/home_screen.dart';
import 'package:flutter_design_challenge/screens/walk_through_screen.dart';
import 'package:flutter_design_challenge/utils/analytics_service.dart';
import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_design_challenge/widgets/firebase_init_widget.dart';

final kReleaseMode = true;

void main() async {
  ///This is to make sure app supports only portrait orientation
  WidgetsFlutterBinding.ensureInitialized();
  await Services.SystemChrome.setPreferredOrientations(
      [Services.DeviceOrientation.portraitUp]);
  runZoned(() {
    runApp(kReleaseMode
        ? MyApp()
        : DevicePreview(
            enabled: !kReleaseMode,
            builder: (context) => MyApp(),
          ));
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends FirebaseInitWidget {
  @override
  Widget getApp() {
    return MaterialApp(
      title: 'Flutter Inspiration',
      builder: DevicePreview.appBuilder,
      theme: ThemeData(
        primarySwatch: darkBlueGray,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeBuilder(),
      navigatorObservers: [
        AnalyticsService().getAnalyticsObserver(),
      ],
    );
  }

  @override
  Widget getInitErrorWidget() {
    print("Error while Firebase Init");
    //TODO: add error indicator
    return Container(
      color: Colors.red,
    );
  }

  @override
  Widget getLoadingWidget() {
    //TODO: add progress indicator
    return Container(
      color: Colors.black,
    );
  }
}

class HomeBuilder extends StatefulWidget {
  @override
  _HomeBuilderState createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {
  bool _isFirstTime;

  @override
  void initState() {
    getIsFirstTimeState().then((value) {
      _isFirstTime = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime == null) {
      return Container(
        color: Colors.black,
      );
    } else
      return _isFirstTime ? WalkThroughScreen() : HomeScreen();
  }
}
