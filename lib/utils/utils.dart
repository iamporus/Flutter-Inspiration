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
