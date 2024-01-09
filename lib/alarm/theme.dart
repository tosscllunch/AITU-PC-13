import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarLightTheme,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.teal),
    primaryIconTheme: const IconThemeData(color: Colors.teal),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: Colors.teal),
      bodyText2: const TextStyle(color: Colors.teal),
      headline4: const TextStyle(color: Colors.teal, fontSize: 32),
      headline1: const TextStyle(color: Colors.teal, fontSize: 80),
    ),
    colorScheme: const ColorScheme.light(
      secondary: Colors.teal,
      secondaryContainer: Colors.teal,
      primary: Colors.teal,
      onPrimary: Colors.white,
      // on light theme surface = Colors.white by default
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: const Color(0xFF0D0C0E),
    appBarTheme: appBarDarkTheme,
    backgroundColor: kBackgroundDarkColor,
    iconTheme: const IconThemeData(color: kBodyTextColorDark),
    primaryIconTheme: const IconThemeData(color: kPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyText1: const TextStyle(color: Colors.teal),
      bodyText2: const TextStyle(color: Colors.teal),
      headline4: const TextStyle(color: Colors.teal, fontSize: 32),
      headline1: const TextStyle(color: Colors.teal, fontSize: 80),
    ),
    colorScheme: const ColorScheme.dark(
      secondary: Colors.teal,
      secondaryContainer: Colors.teal,
      surface: kSurfaceDarkColor,
      onSurface: Colors.teal,
      primary: Colors.teal,
      onPrimary: kBackgroundDarkColor,
    ),
  );
}

AppBarTheme appBarLightTheme = AppBarTheme(
  // affect the color of SystemUI
  color: Colors.white.withOpacity(0),
  elevation: 0,
);
AppBarTheme appBarDarkTheme = AppBarTheme(
  // affect the color of SystemUI
  color: Colors.black.withOpacity(0),
  elevation: 0,
);
