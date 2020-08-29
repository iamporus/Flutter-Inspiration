import 'package:flutter/material.dart';

class SettingsCollapseModel with ChangeNotifier {
  bool _isSettingsCollapsed = false;
  
  bool get isSettingsCollapsed => _isSettingsCollapsed;
  
  set isSettingsCollapsedValue(bool value) {
    _isSettingsCollapsed = value;
    notifyListeners();
  }
  
}
