import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oqyga_frontend/shared/themes/pallete.dart';

class AppTheme {
  static final lightThemeMode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    primaryColor: AppPallete.buttonColor,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.buttonColor,
      secondary: AppPallete.borderColor,
      surface: AppPallete.backgroundColor,
    ),

    textTheme: GoogleFonts.juraTextTheme().apply(
      bodyColor: AppPallete.borderColor,
      displayColor: AppPallete.borderColor,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppPallete.buttonColor,
      indicatorColor: AppPallete.navigateButton,
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? Colors.white
              : Colors.white70,
          size: 34,
        );
      }),
      labelTextStyle: WidgetStateProperty.all(
        GoogleFonts.jura(color: Colors.white),
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppPallete.borderColor),
      titleTextStyle: GoogleFonts.jura(
        color: AppPallete.borderColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.jura(color: AppPallete.borderColor),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppPallete.buttonColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppPallete.borderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppPallete.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPallete.buttonColor,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.jura(fontSize: 24, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      ),
    ),
  );
}
