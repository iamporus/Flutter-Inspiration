import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Services;
import 'package:flutter_design_challenge/screens/SettingsScreen.dart';
import 'package:flutter_design_challenge/widgets/BackdropWidget.dart';

import 'screens/DesignListScreen.dart';

final kReleaseMode = true;

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
      home: BackdropWidget(
        settingsScreen: SettingsScreen(),
        homeBuilder: (context, isSettingsOpen) {
          return DesignListScreen(
            isSettingsOpen: isSettingsOpen,
          );
        },
      ),
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
