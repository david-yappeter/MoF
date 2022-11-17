import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myProvider extends ChangeNotifier {
  var light = ThemeData(brightness: Brightness.light);

  var dark = ThemeData(
    brightness: Brightness.dark,
    bottomNavigationBarTheme:
        const BottomNavigationBarThemeData(backgroundColor: Colors.black45),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF00B2FF),
        fontSize: 40.0,
        fontWeight: FontWeight.w500,
        fontFamily: 'Exo',
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Exo',
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 11.0,
        fontWeight: FontWeight.w400,
        fontFamily: 'Poppins',
      ),
    ),
  );

  bool enableDarkMode = false;

  bool get getenableDarkMode => enableDarkMode;

  set setBrightness(val) {
    enableDarkMode = val;
    notifyListeners();
  }

  final String keySwitch = 'switch';
  late SharedPreferences prefs;
  bool status = false;

  bool get getStatus => status;

  void loadData() async {
    prefs = await SharedPreferences.getInstance();
    status = ((prefs.getBool(keySwitch) ?? false));
    notifyListeners();
  }

  Future<void> setStatus(bool value) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(keySwitch, value);
    status = ((prefs.getBool(keySwitch) ?? false));
    notifyListeners();
  }
}
