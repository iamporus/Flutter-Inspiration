import 'package:flutter/material.dart';
import 'package:flutter_design_challenge/models/Design.dart';

class DesignChangeModel with ChangeNotifier {
  int _currentDesignIndex = 0;

  int get currentDesignIndex => _currentDesignIndex;

  set currentDesignValue(int index) {
    _currentDesignIndex = index;
    notifyListeners();
  }
}
