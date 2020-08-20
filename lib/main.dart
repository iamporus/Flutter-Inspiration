import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_design_challenge/screens/HomeScreen.dart';
import 'package:flutter_design_challenge/screens/WalkThroughScreen.dart';
import 'package:flutter_design_challenge/utils/analytics_service.dart';
import 'package:flutter_design_challenge/utils/utils.dart';

final kReleaseMode = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  await Services.SystemChrome.setPreferredOrientations(
      [Services.DeviceOrientation.portraitUp]);
  runApp(kReleaseMode
      ? MyApp()
      : DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => MyApp(),
        ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

  final MaterialColor darkBlueGray = const MaterialColor(
    0xFF37474f,
    const <int, Color>{
      50: const Color(0xFF37474f),
      100: const Color(0xFF37474f),
      200: const Color(0xFF37474f),
      300: const Color(0xFF37474f),
      400: const Color(0xFF37474f),
      500: const Color(0xFF37474f),
      600: const Color(0xFF37474f),
      700: const Color(0xFF37474f),
      800: const Color(0xFF37474f),
      900: const Color(0xFF37474f),
    },
  );
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
