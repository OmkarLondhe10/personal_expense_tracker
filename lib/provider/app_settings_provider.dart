import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier{
  bool _darkmode = false;
  bool _notificationsEnabled = false;

  bool get darkmode => _darkmode;
  bool get notificationsEnabled => _notificationsEnabled;

  AppSettingsProvider(){
    _loadsettings();
  }
  
  Future <void> _loadsettings() async{
    final prefs = await SharedPreferences.getInstance();
    _darkmode = prefs.getBool('darkMode') ?? false;
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    notifyListeners();
  }

  Future <void> tottgleDarkMode (bool value) async {
    _darkmode = value;
    notifyListeners();
  }

  Future <void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
  }
}