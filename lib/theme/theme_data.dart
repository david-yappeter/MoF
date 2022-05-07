import 'package:flutter/material.dart';
import 'package:mof/theme/colors.dart';

ThemeData customTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: CustomColor.white,
    elevation: 5,
    titleTextStyle: TextStyle(
      color: Colors.black,
    ),
    toolbarTextStyle: TextStyle(
      color: CustomColor.primary,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Colors.black,
    unselectedLabelColor: Colors.black54,
    labelPadding: EdgeInsets.symmetric(horizontal: 30),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: Colors.black, width: 2),
    ),
  ),
  primarySwatch: const MaterialColor(0xFF6A39FF, {
    50: Color(0xFFE8E8E8),
    100: Color(0xFFBDBDBD),
    200: Color(0xFF9E9E9E),
    300: Color(0xFF757575),
    400: Color(0xFF616161),
    500: Color(0xFF6A39FF),
    600: Color(0xFF5E35DC),
    700: Color(0xFF512DA8),
    800: Color(0xFF452794),
    900: Color(0xFF311B52),
  }),
  primaryColor: const Color(0xFF6A39FF),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: CustomColor.secondary,
    background: CustomColor.background,
    onBackground: CustomColor.white,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: Color(0xFF00B2FF),
      fontSize: 40.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Exo',
    ),
    headline2: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Exo',
    ),
  ),
);
