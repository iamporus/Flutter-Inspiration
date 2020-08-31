import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const String PREFS_KEY_IS_FIRST_TIME = "is_firstTime";
const String PREFS_KEY_NO_OF_APP_OPEN_INSTANCES =
    "key_no_of_app_open_instances";
const int GOOD_NO_OF_APP_OPEN_INSTANCES_TO_SHOW_REVIEW = 4;

Future<bool> getIsFirstTimeState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(PREFS_KEY_IS_FIRST_TIME) ?? true;
}

Future<bool> getIsGoodTimeToAskReview() async {
  int appOpenInstances = await _getNoOfAppOpenInstances();
  if (appOpenInstances % GOOD_NO_OF_APP_OPEN_INSTANCES_TO_SHOW_REVIEW == 0)
    return true;
  else
    return false;
}

Future<bool> updateNoOfAppOpenInstances() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  int appOpenInstances = await _getNoOfAppOpenInstances();
  appOpenInstances++;
  print("App Open: " + appOpenInstances.toString());
  return prefs.setInt(PREFS_KEY_NO_OF_APP_OPEN_INSTANCES, appOpenInstances);
}

Future<int> _getNoOfAppOpenInstances() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.get(PREFS_KEY_NO_OF_APP_OPEN_INSTANCES) ?? 0;
}

Future<bool> dissolveFirstTimeState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool(PREFS_KEY_IS_FIRST_TIME, false);
}

void launchURL(BuildContext context, String sourceCodeUrl) async {
  if (await canLaunch(sourceCodeUrl)) {
    await launch(sourceCodeUrl);
    //TODO: force WebView with desktop site
  } else {
    //TODO: this will crash if scaffold is not part of the view hierarchy.

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not launch $sourceCodeUrl'),
      ),
    );
  }
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
