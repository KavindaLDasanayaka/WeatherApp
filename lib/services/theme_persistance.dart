import 'package:shared_preferences/shared_preferences.dart';

class ThemePersistance {
  // Store the user's saved theme in shared preferences
  Future<void> storeTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //dan sshared preference wala bool ekak store karagamma ona pass karana bool eka
    prefs.setBool("isDark", isDark);
  }

  //Load the user's saved theme from shared preferences

  Future<bool> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isDark") ?? false;
  }
}
