import 'package:shared_preferences/shared_preferences.dart';
import 'package:faltu/constants/constants.dart';

class SetPreferences {
  static void saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.EMAIL, email);
  }

  static void saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.NAME, name);
  }

  static void saveURL(String url) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.URL, url);
  }

  static void savePhone(String phoneNumber) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.PHONE, phoneNumber);
  }

  static void saveGender(String gender) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.GENDER, gender);
  }

  static void saveId(String id) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.ID, id);
  }

  static void clear() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
