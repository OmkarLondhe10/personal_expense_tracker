import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future <String?> getsavedUserEmail();
  Future<void> saveUserEmail(String email);
  Future<void> clearUser();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource{
  static const _key = 'logged_user';


  @override
  Future<String?> getsavedUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }

  @override
  Future<void> saveUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, email);
  }
  
  @override
  Future<void> clearUser() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

}