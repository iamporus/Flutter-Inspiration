import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/DesignListScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design Challenges',
      theme: ThemeData(
        primarySwatch: darkBlueGray,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DesignListScreen(),
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
