import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_IS_FIRST_TIME = "is_firstTime";

Future<bool> getIsFirstTimeState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(PREFS_KEY_IS_FIRST_TIME) ?? true;
}

Future<bool> dissolveFirstTimeState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(PREFS_KEY_IS_FIRST_TIME, false);
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
