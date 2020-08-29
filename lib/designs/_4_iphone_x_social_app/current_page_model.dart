import 'package:flutter/foundation.dart';

class CurrentPageModel with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  set currentPageValue(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
