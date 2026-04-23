import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier{
  bool _darkmode = false;

  bool get darkmode => _darkmode;

  AppSettingsProvider(){
    _loadsettings();
  }
  
  Future <void> _loadsettings() async{
    final prefs = await SharedPreferences.getInstance();
    _darkmode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  Future <void> tottgleDarkMode (bool value)  async {
    _darkmode = value;
    notifyListeners();
  }
}