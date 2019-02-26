import 'package:faltu/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPreferences{
  static Future<String> getEmail() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.EMAIL);
  }

  static Future<String> getName() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.NAME);
  }

  static Future<String> getURL() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.URL);
  }

  static Future<String> getPhone() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.PHONE);
  }

  static Future<String> getGender() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.GENDER);
  }

  static Future<String> getId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constants.ID);
  }
}