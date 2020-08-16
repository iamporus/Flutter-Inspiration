import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_design_challenge/screens/SettingsScreen.dart';
import 'package:flutter_design_challenge/widgets/BackdropWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase_widget.dart';

import 'screens/DesignListScreen.dart';

final kReleaseMode = true;
const String PREFS_KEY_IS_FIRST_TIME = "is_firstTime";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Services.SystemChrome.setPreferredOrientations(
      [Services.DeviceOrientation.portraitUp]);
  runApp(DevicePreview(
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
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isFirstTime;

  @override
  void initState() {
    _getIsFirstTimeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstTime == null) {
      return Container(
        color: Colors.black,
      );
    } else
      return _isFirstTime ? _buildHomeWithShowCase(context) : _getHome();
  }

  ShowCaseWidget _buildHomeWithShowCase(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(builder: (context) {
        return _getHome();
      }),
      onFinish: () {
        //TODO: notify user about end of showcase.
        _setIsFirstTimeState();
      },
    );
  }

  Future _getIsFirstTimeState() async {
    final SharedPreferences prefs = await _prefs;

    _isFirstTime = prefs.get(PREFS_KEY_IS_FIRST_TIME) ?? true;
    setState(() {});
  }

  void _setIsFirstTimeState() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(PREFS_KEY_IS_FIRST_TIME, false).then((value) {
      _isFirstTime = false;
    });
  }

  Widget _getHome() {
    return BackdropWidget(
      settingsScreen: SettingsScreen(),
      homeBuilder: (context, isSettingsOpen) {
        return DesignListScreen(
          isSettingsOpen: isSettingsOpen,
          isFirstTime: _isFirstTime,
        );
      },
    );
  }
}
