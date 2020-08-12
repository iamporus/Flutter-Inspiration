import 'package:flutter/material.dart';

class DesignChangeModel with ChangeNotifier {
  int _currentDesignIndex = 0;
  int _previousDesignIndex = 0;

  int get currentDesignIndex => _currentDesignIndex;

  int get previousDesignIndex => _previousDesignIndex;

  set currentDesignValue(int index) {
    _currentDesignIndex = index;
    notifyListeners();
  }

  set previousDesignValue(int index) {
    _previousDesignIndex = index;
    notifyListeners();
  }
}
