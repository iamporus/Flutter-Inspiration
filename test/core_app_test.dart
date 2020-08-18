import 'package:flutter_design_challenge/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Can first time users get identified', () async {
    SharedPreferences.setMockInitialValues({PREFS_KEY_IS_FIRST_TIME: true});

    Future<bool> isFirstTime = getIsFirstTimeState();
    isFirstTime.then((value) => expect(value, true));
  });

  test('Can first time users get dissolved', () async {
    SharedPreferences.setMockInitialValues({});

    dissolveFirstTimeState().then((value) {
      Future<bool> isFirstTime = getIsFirstTimeState();
      isFirstTime.then((value) => expect(value, false));
    });
  });
}
